---
layout: post
title: "Experimental Mongo Instrumentation (for Rails 3)"
tags: [ruby, rails, rails3, mongo, instrumentation]
draft: true
---

class Api::Presenter
  include Rails.application.routes.url_helpers

  attr_accessor :controller, :subject

  delegate :params, :url_options, :to => :controller
  delegate :errors, :to => :subject

  def initialize(controller, subject)
    @controller = controller
    @subject = subject
  end
end

class Api::MessagePresenter < Api::Presenter
  def as_json(options = {})
    {
      :uri => uri,
      :content => subject.content,
      :sent => subject.sent?,
      :favourite => subject.favourite?,
      :timestamp => subject.timestamp.utc,
    }
  end

  def uri
    api_message_url(:id => subject.id)
  end
end

class Api::MessagesController < ApplicationController::Base
  def show
    @message.find
  end
end