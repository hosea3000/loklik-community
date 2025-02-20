# frozen_string_literal: true

HelloModule::Engine.routes.draw do
  get "/hello" => "examples#index"

  # base routes
  get "/base/banner-list" => "base#banner_list"
  get "/base/is-sync" => "base#is_sync"
  get "/base/search" => "base#search"
  post "/base/upload" => "base#upload"
  get "/base/discourse-host" => "base#discourse_host"

  # category routes
  get "/category/region-list" => "category#region_list"
  get "/category/all" => "category#all"
  get "/category/list" => "category#list"
  get "/category/:id" => "category#show"

  # post routes
  get "/post/curated-list" => "post#curated_list"
  get "/post/latest-list" => "post#latest_list"
  get "/post/list/:id" => "post#list_show"
  get "/post/:id" => "post#show"
  get "/post/:id/comment-list" => "post#comment_list"
  get "/post/:topic_id/comment-list/:post_number" => "post#topic_comment_list"
  get "/post/:topic_id/collect" => "post#topic_collect"
  get "/post/:topic_id/like" => "post#topic_like"
  put "/post/:topic_id/cancel-collect" => "post#topic_collect_cancel"
  put "/post/:topic_id/cancel-like" => "post#topic_like_cancel"

  # admin routes
  get "/admin/index" => "admin#index"
  put "/admin/curated/:topic_id" => "admin#curated"
end

Discourse::Application.routes.draw { mount ::HelloModule::Engine, at: "loklik" }
