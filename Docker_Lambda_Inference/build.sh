docker build --platform linux/amd64 -t actionartisan-endpoint:test .

# create a private repo for it action artisan
# docker tag actionartisan-endpoint:test <id>.dkr.ecr.us-east-1.amazonaws.com/actionartisan 
# docker push <id>.dkr.ecr.us-east-1.amazonaws.com/actionartisan  