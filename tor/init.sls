# vim: ft=sls
# Init tor
{%- from "tor/map.jinja" import tor with context %}

include:
  - tor.test
