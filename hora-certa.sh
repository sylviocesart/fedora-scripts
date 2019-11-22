#######################################
# SCRIPT PARA AJUSTAR A HORA VIA HTTP #
# Autor: Sylvio Cesar                 #
# Data: 15.08.2019                    #
#                                     #
#######################################
# Exportando proxy
export https_proxy="http://proxyprd.caixa:80"
export http_proxy="http://proxyprd.caixa:80"

# Ajustando hora utilizando como base o google.com
httpdate="$(wget --no-cache -S -O /dev/null google.com 2>&1 | sed -n -e 's/  *Date: *//p' -eT -eq)"
[ -n "$httpdate" ] && date -s "$httpdate"
