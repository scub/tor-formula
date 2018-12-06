# vim: ft=sls
# Init tor
{%- from "tor/map.jinja" import tor with context %}
{# Below is an example of having a toggle for the state #}



{% if tor.tor is defined %}
'tor.init: tor.tor is defined from map.jinja lol':
  test.succeed_without_changes
{% endif %}

{% if tor.stuff is defined %}
'tor.init: tor.stuff is defined from map.jinja':
  test.succeed_without_changes
{% endif %}




{% if tor.enabled %}
include:
  - tor.install
  - tor.config
  - tor.service
{% else %}
'tor-formula disabled':
  test.succeed_without_changes
{% endif %}

