---
layout: default
title: Refget Compliance Report
---

<table class="primary">
  <thead>
  <tr>
    <th>Server</th>
    {% for description in site.data.descriptions %}
      <th>{{ description[1] }}</th>
    {% endfor %}
  </tr>
  </thead>
  <tbody>
    {% for server in site.data.servers %}
    {% assign server_key=server[0] %}
    {% assign results=site.data[server_key][0] %}
    {% assign report_link="/reports/" | append: server_key | append: '.html' %}
    <tr>
      <td><a href='{{ site.baseurl }}{{report_link}}'>{{ results.server }}</a></td>
      {% for result in results.test_results %}
        {% for description in site.data.descriptions %}
          {% assign testname = description[0] %}
          {% if result.name == testname %}
          {% case result.result %}
              {% when 1 %}
              {% assign class='success' %}
              {% assign text='Pass' %}
              {% when 0 %}
              {% assign class='warning' %}
              {% assign text='Warning' %}
              {% when -1 %}
              {% assign class='error' %}
              {% assign text='Fail' %}
              {% endcase %}
            <td><span class='label {{class}}'>{{text}}</span></td>
          {% endif %}
        {% endfor %}
      {% endfor %}
    </tr>
    {% endfor %}
  </tbody>
</table>
