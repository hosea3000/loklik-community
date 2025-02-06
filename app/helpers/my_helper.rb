module MyHelper
  def render_response(data: nil, code: 200, success: true, msg: "操作成功")
    if data.is_a?(String)
      begin
        parsed_data = JSON.parse(data)
      rescue JSON::ParserError
        # 如果解析失败，使用原始字符串
        parsed_data = data
      end
    else
      parsed_data = data
    end

    render json: response_format(data: parsed_data, code: code, success: success, msg: msg), status: code
  end

  def response_format(data: nil, code: 200, success: true, msg: "操作成功")
    {
      code: code,
      success: success,
      data: data,
      msg: msg
    }
  end

  def create_page_list(data, total, current, size)
    {
      records: data,
      total: total,
      size: size,
      current: current
    }
  end

  def get_request_host
    # 获取当前请求的完整 URL
    # request_url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
    "#{request.protocol}#{request.host_with_port}"
  end
end
