docker run --name lambdatest -p 9000:8080 ActionArtisan-image:test 

# curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'

# curl "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"payload":"hello world!"}'

# docker ps

# docker kill lambdatest

# docker tag id-imagen public.ecr.aws/<path registry>/actionartisan