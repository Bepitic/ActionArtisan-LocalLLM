import Scales_data as dta
import json
import os
import logging
import math

import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)
logger.info('Loading function')

def handler(event:dict, context:dict[str,object]) -> dict[str,object]:
    '''
    Returns the response of the api call to openAI that narrates the action of the character.

    Parameters:
        event (json):The http call that came to the lambda in json format.
        context (dict):The contex object provides methods and properties that provide information about the invocation, function, and execution environment.

    Returns:
        return(str): A http response for the call in a json format, and in the body the response of the API call of openAI.   
    '''
  
    logger.info(event)
    if "body" in event:
        event_body = event["body"]
        e_body_json = json.loads(event_body)
    else:
        e_body_json = event
    # print(event_body)

    logger.info("name = " + e_body_json['name'])
    logger.info("race = " + e_body_json['race'])
    logger.info("action = " + e_body_json['action'])
    logger.info("dice = " + e_body_json['dice'])
    logger.info("difficulty = " + e_body_json['difficulty'])


    difficulty_str = dta._DIFFICULTY_SCALE[int(e_body_json['difficulty'])]
    luck_outcome = luck(int(e_body_json['dice']), int(e_body_json['difficulty']))
 
    prompt =  f"Explain how '{e_body_json['name']}' a {e_body_json['race']} tried to {e_body_json['action']} of {difficulty_str} difficulty and got an{luck_outcome}, in one paragraph"


    max_new_tokens = int(os.environ.get('MAX_NEW_TOKENS',256))

    payload = {
        "inputs" : prompt,
        "parameters" : {
            "max_new_tokens" : max_new_tokens, 
        }
    }

    endpoint_n = os.environ.get('ENDPOINT_NAME',"falcon-rol" )
    noPrompt = os.environ.get('STRIP_PROMPT',True )

    runtime = boto3.client("runtime.sagemaker")

    response = runtime.invoke_endpoint(EndpointName=endpoint_n, ContentType="application/json", Body=json.dumps(payload))
    res = response['Body'].read().decode('utf8')

    if noPrompt:
        res = json.loads(res)[0]['generated_text'][len(prompt):]
    else:
        res = json.loads(res)[0]['generated_text']

    logger.info("after inference")
    logger.info(res)
    return {
        'statusCode': 200,
        'headers': {
            "Access-Control-Allow-Origin": '*',
            "Access-Control-Allow-Headers": '*',
            "Access-Control-Allow-Methods": '*',
        },
        'body': res #json.dumps(res)
    }


def luck(luck: int, difficult: int) -> str:
    '''
    Returns the achivement String of an action based on the difference in the difficulty and the luck of the character that performs the action.

    Parameters:
        luck (int):The final modifier that the character has after throwing the dice.(1-20)
        difficult (int):The difficulty that the DM(Dungeon Master) gives to the action of the character.(1-20)

    Returns:
        resp(str):The achivement based on the difference in the difficulty and the luck of the character.   
    '''

    achievement_scale = dta._ACHIEVEMENT_SCALE

    if luck == 1:
        return achievement_scale[0]
    if luck == 20:
        return achievement_scale[9]

    difference = luck - difficult
    resp = achievement_scale[5]

    if difference < 0 :
        # negative
        difference *= -1;
        difference = (difference/4)%4;
        difference += 1; 

        resp = achievement_scale[math.floor(difference)];

    else:
        # positive
        difference += 1;
        difference = (difference/4)%4;
        difference += 5; 
        resp = achievement_scale[math.floor(difference)];


    # if difference < 0:
    #     resp = achievement_scale[4]
    # if difference < -2:
    #     resp = achievement_scale[3]
    # if difference < -5:
    #     resp = achievement_scale[2]
    # if difference < -7:
    #     resp = achievement_scale[1]

    # if difference >= 0:
    #     resp = achievement_scale[5]
    # if difference >= 2:
    #     resp = achievement_scale[6]
    # if difference >= 5:
    #     resp = achievement_scale[7]
    # if difference >= 7:
    #     resp = achievement_scale[8]

    return resp