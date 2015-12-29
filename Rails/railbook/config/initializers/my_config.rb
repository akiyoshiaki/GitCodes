#設定ファイルを初期化ファイルで明示的に読み込む
MY_APP = YAML.load(
  File.read("#{Rails.root}/config/my_config.yml"))[Rails.env]
