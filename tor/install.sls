# vim: ft=sls
# How to install tor
{%- from "tor/map.jinja" import tor with context %}

tor_pkg:
  pkg.installed:
    - name: {{ tor.pkg }}

