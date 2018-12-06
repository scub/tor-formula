# vim: ft=sls
# How to configure tor
{%- from "tor/map.jinja" import tor with context %}

tor_config:
  file.managed:
    - name: '/tmp/config.conf'
    - source: salt://tor/files/config.conf
    - user: root
    - group: root
    - mode: 0600
    - template: jinja
    - local_string: 'test string please ignore'

