---
layout: default
title: Refget Compliance Report
---

## Results
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
        {% for description in site.data.descriptions %}
          {% assign testname = description[0] %}
          {% assign summary=results.high_level_summary[testname] %}
          {% assign lookup=site.data.result[summary.result] %}
          <td><span class='label {{lookup.class}}'>{{lookup.text}}</span></td>
        {% endfor %}
    </tr>
    {% endfor %}
  </tbody>
</table>

## Useful Links
- [Refget specification](https://samtools.github.io/hts-specs/refget.html)
- [Compliance document](https://compliancedoc.readthedocs.io/)
- [Compliance tool](https://github.com/ga4gh/refget-compliance-suite)