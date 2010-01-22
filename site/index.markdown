---
layout: default
title: "Tom Ward's blog"
description: "Personal blog of Tom Ward, in which he writes about ruby, rails and web development, as well as other random ephemera"
---
{% for page in site.posts.by_date.reversed limit:5 %}
{% include 'post' with page %}
{% endfor %}
