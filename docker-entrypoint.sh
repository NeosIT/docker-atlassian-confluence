#!/bin/bash

# check if the `server.xml` file has been changed since the creation of this
# Docker image. If the file has been changed the entrypoint script will not
# perform modifications to the configuration file.
if [ "$(stat -c "%Y" "${CONF_INSTALL}/conf/server.xml")" -eq "0" ]; then
  if [ -n "${X_PROXY_NAME}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "proxyName" --value "${X_PROXY_NAME}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PROXY_PORT}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "proxyPort" --value "${X_PROXY_PORT}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PROXY_SCHEME}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "scheme" --value "${X_PROXY_SCHEME}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PROXY_SECURE}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "secure" --value "${X_PROXY_SECURE}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PATH}" ]; then
    xmlstarlet ed --inplace --pf --ps --update '//Context[@docBase="../confluence"]/@path' --value "${X_PATH}" "${CONF_INSTALL}/conf/server.xml"
  fi
fi

if [ "$(stat -c "%Y" "${CONF_INSTALL}/confluence/WEB-INF/classes/seraph-config.xml")" -eq "0" ]; then
  if [ "${X_CROWD_SSO}" = "true" ]; then
    xmlstarlet ed --inplace -u "/security-config/authenticator[@class='com.atlassian.confluence.user.ConfluenceAuthenticator']/@class" -v "com.atlassian.confluence.user.ConfluenceCrowdSSOAuthenticator" "${CONF_INSTALL}/confluence/WEB-INF/classes/seraph-config.xml"
    export CATALINA_OPTS="${CATALINA_OPTS} -Dcrowd.properties=${CONF_HOME}/crowd.properties"
  fi
fi

exec "$@"
