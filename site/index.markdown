---
layout: default
title: recent posts
description: "Tom Ward's web development blog"
---
{% for page in site.posts limit:5 %}
{% assign body = page.content %}
{% include post-div.html %}
{% endfor %}