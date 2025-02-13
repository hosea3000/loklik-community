# frozen_string_literal: true

require "bunny"

module ::HelloModule
  class ExamplesController < ::ApplicationController
    requires_plugin PLUGIN_NAME
    include MyHelper
    skip_before_action :verify_authenticity_token # 跳过认证
    def index
      # 获取请求中的所有 headers
      headers = request.headers.env.select { |k, _| k.start_with?('HTTP_') }

      # 格式化 headers 为 JSON
      formatted_headers = headers.transform_keys { |k| k.sub('HTTP_', '').split('_').map(&:capitalize).join('-') }

      token = request.get_header("HTTP_SJTOKEN")

      res = {
        hello: "world",
        token: token,
        headers: formatted_headers
      }
      render_response(data: res)
    end

    def test_sync_user
      msg = '{
    "avatarUrl": "http://s3.amazonaws.com/loklik-idea-studio-public-dev/avatar/1831162626387005440.png",
    "email": "335072884@qq.com",
    "isUpgrade": 1,
    "name": "wu4",
    "surname": "qf4",
    "userId": "1817839402091683844",
    "username": "u_qf4"
}'
      res = ConsumerService.consumer_user_login(msg)
      render_response(data: res)
    end

    def test_post
      render_response(data: "test_post")
    end

    def test_amqp
      amqp_connect_string = params[:amqp_connect_string]
      LoggerHelper.info("AMQP connect string: #{amqp_connect_string}")
      @connection = Bunny.new(amqp_connect_string)
      @connection.start
      LoggerHelper.info("AMQP connection started")
      @channel = @connection.create_channel
      LoggerHelper.info("AMQP channel created")
      @queue = @channel.queue('loklik:ideastudio:community:login.sync.queue', durable: true)
      LoggerHelper.info("AMQP queue created")
      @connection.close
      render_response
    rescue Exception => e
      LoggerHelper.error("AMQP connection error: #{e.message}")
      render_response(msg: e.message)
    end
  end
end
