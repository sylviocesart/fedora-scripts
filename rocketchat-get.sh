#################################################
##   Script para automatizar o download        ##
##   de novas versões do caixa.rocket.chat     ##
##   disponibilizadas no docker hub do rocket  ##
##                                             ##
##   Autor: Sylvio Cesar                       ##
##   Data: 09.07.2019                          ##
##                                             ##
#################################################
#!/bin/bash

TOKEN="eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJvcGVuc2hpZnQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlY3JldC5uYW1lIjoicHVzaHJvY2tldC10b2tlbi1sN245biIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJwdXNocm9ja2V0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiMTlmNGRhOTctYTI3ZC0xMWU5LWIzMDQtMDA1MDU2OGE1NTQ0Iiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Om9wZW5zaGlmdDpwdXNocm9ja2V0In0.gmK1xxxnyGl8vgDLr-ZD5L-3CORfEJJwaGXtKnZrVcsZEdlhj9WzMlB_worA0mMhmwAfSwH42cQ4R2n3_Nfu_PuEWHhomtmv4Ql07A0TAtc3I4cxBys-YDdoX59xn2jISrxTGYnS-Sob2TrTdC718Iz7jrSg9-_oQC1A9XgMgT7LOXRkEFA1UyhWxGlicvCcLHU22tLSAFMs3o9EpncgD55VM0iwJOf3YCASKHm4vNPB8sEGCI2q-r6ErzNNEX2KAXF1Yj--zSiPYZ_TB1LyIB4eFIbbhPniaNvtxMVp4zEbafz3_CNgqp0_GjutsbugIns0yOcgbeYgBfU2p8gQuA"

oc login --token=$TOKEN

## Baixando a mais recente imagem do RocketChat
TAG01=`curl --proxy proxyprd.caixa:80 https://registry.hub.docker.com/v2/repositories/rocketchat/caixa.rocket.chat/tags/|jq '."results"[]["name"]' | head -n1 | sed 's/"//g'`
docker pull rocketchat/caixa.rocket.chat:$TAG01
ID_TAG=`docker images | grep $TAG01 | awk '{print $3}'`
docker tag $ID_TAG01 docker-registry.default.svc:5000/openshift/caixa.rocket.chat:$TAG01
docker login -u pushrocket docker-registry.default.svc:5000 -p $TOKEN
docker push docker-registry.default.svc:5000/openshift/caixa.rocket.chat:$TAG01


## Baixando a penultima imagem mais recente do RocketChat
TAG02=`curl --proxy proxyprd.caixa:80 https://registry.hub.docker.com/v2/repositories/rocketchat/caixa.rocket.chat/tags/|jq '."results"[]["name"]' | head -n2 | tail -n1 | sed 's/"//g'`
docker pull rocketchat/caixa.rocket.chat:$TAG02
ID_TAG02=`docker images | grep $TAG02 | awk '{print $3}'`
docker tag $ID_TAG02 docker-registry.default.svc:5000/openshift/caixa.rocket.chat:$TAG02
docker login -u pushrocket docker-registry.default.svc:5000 -p $TOKEN
docker push docker-registry.default.svc:5000/openshift/caixa.rocket.chat:$TAG02

oc logout
