#!/usr/bin/env bash
# exit on error
set -o errexit

# 依存関係のインストール
bundle install

# アセットのプリコンパイル
bundle exec rake assets:precompile
bundle exec rake assets:clean

# データベースのマイグレーション
bundle exec rake db:migrate 