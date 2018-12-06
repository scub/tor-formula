# vim: ft=sls
#
{% from "tor/map.jinja" import tor with context %}

# Default values are still present in "tors" context
{% if tor.unique_default is defined %}
'tor.test: show defaults.yml provided tor.unique_default values if available: {{ tor.unique_default }}':
  test.succeed_without_changes
{% endif %}

{% if tor.os_family_map is defined %}
'tor.test: show context provided tor.os_family_map value: {{ tor.os_family_map }}':
  test.succeed_without_changes
{% endif %}

{% if tor.os_codename is defined %}
'tor.test: show context provided tor.os_codename value: {{ tor.os_codename }}':
  test.succeed_without_changes
{% endif %}

{% if tor.shared is defined %}
  {% for key, val in tor.shared.iteritems() %} 
'tor.test: show context provided tor.shared key/value pairs: [{{ key }}] = {{ val }}':
  test.succeed_without_changes
  {% endfor %}
{% endif %}

{### BUILD OUT A YAML REPRESENTATION OF WHAT VALUES ARE SEEN HERE ###}
{% set context_file = "/tmp/formula_context_" ~ tor.os_codename %}
'tor.test: ensure previous contexts are cleared':
  file.absent:
    - name: {{ context_file }} 

'tor.test: create formula_context file':
  file.managed:
    - name: {{ context_file }} 
    - contents: "tor:"

{% for key, val in tor.iteritems() %}

  # Top Level Keys
  {% if val is not mapping %}
'tor.test: update mapping file for {{key}}':
  file.append:
    - name: {{ context_file }} 
    - text: "  {{ key }}:  '{{ val }}'"
  {% endif %}

  # Nested/Potentially shared keys
  {% if val is mapping %}
'tar.test: updating mapping file with nested structure {{ key }}':
  file.append:
    - name: {{ context_file }}
    - text: "  {{ key }}:"

  {% for nk, nv in val.iteritems() %}
    {% if nv is not mapping %}
'tar.test: update mapping file for nested key {{key}}.{{nk}}.{{nv}}':
  file.append:
    - name: {{ context_file }}
    - text: "    {{nk}}: '{{nv}}'"
    {% endif %}
  {% endfor %}{% endif %}
{% endfor %}
