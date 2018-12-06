# vim: ft=sls
# Manage service for service tor
{%- from "tor/map.jinja" import tor with context %}

'tor-service not configured':
  test.succeed_without_changes

#tor_service:
#  service.running:
#    - name: tor
#    - enable: True
#    - watch:
#        - file: tor_config

