# Payjpの公開鍵を環境変数で使用するためにこのファイルを作成し、以下を記述
Webpacker::Compiler.env["PAYJP_PUBLIC_KEY"] = ENV["PAYJP_PUBLIC_KEY"]