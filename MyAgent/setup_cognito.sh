#!/bin/bash

POOL_ID=$(aws cognito-idp create-user-pool \
  --pool-name "MyAgentUserPool" \
  --policies '{"PasswordPolicy":{"MinimumLength":8}}' \
  --region us-east-2 | jq -r '.UserPool.Id')

CLIENT_ID=$(aws cognito-idp create-user-pool-client \
  --user-pool-id "$POOL_ID" \
  --client-name "MyAgentClient" \
  --no-generate-secret \
  --explicit-auth-flows "ALLOW_USER_PASSWORD_AUTH" "ALLOW_REFRESH_TOKEN_AUTH" \
  --region us-east-2 | jq -r '.UserPoolClient.ClientId')

aws cognito-idp admin-create-user \
  --user-pool-id "$POOL_ID" \
  --username "rashmi-test" \
  --temporary-password "Temp1234!" \
  --region us-east-2 \
  --message-action SUPPRESS > /dev/null

aws cognito-idp admin-set-user-password \
  --user-pool-id "$POOL_ID" \
  --username "rashmi-test" \
  --password "Permanent1234!" \
  --region us-east-2 \
  --permanent > /dev/null

BEARER_TOKEN=$(aws cognito-idp initiate-auth \
  --client-id "$CLIENT_ID" \
  --auth-flow USER_PASSWORD_AUTH \
  --auth-parameters USERNAME='rashmi-test',PASSWORD='Permanent1234!' \
  --region us-east-2 | jq -r '.AuthenticationResult.AccessToken')

echo "Pool ID: $POOL_ID"
echo "Discovery URL: https://cognito-idp.us-east-2.amazonaws.com/$POOL_ID/.well-known/openid-configuration"
echo "Client ID: $CLIENT_ID"
echo "Bearer Token: $BEARER_TOKEN"