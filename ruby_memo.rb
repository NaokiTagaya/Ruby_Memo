require "csv" 
begin
 # メモ書き込みクラス
 class WirteMemo 
 
  # フラグの初期化
  def initialize
   @filename_checkflg = ""
   @existflg = ""
  end
  
  # 新規メモ作成
  def new_memo 
   # ファイル名入力
   puts "拡張子を除いたファイル名を入力してください"
   file_name = gets.chomp.to_s
   # ファイル名チェック
   @filename_checkflg = filename_search(file_name)
   # ファイルがあった場合、処理を終了させる
   if @filename_checkflg == "true" then
     puts "入力されたファイル名は既に作成されています。別のファイル名にするか、編集モードでファイル名を指定してください。"
   else
     # メモ内容入力
     puts "メモしたい内容を記入してください"
     puts "完了したら「Ctrl + D」を押してください"
     puts "--------------------------------------"
     memo_main = gets.to_s
     # メモを保存する
     CSV.open("#{file_name}.csv",'w') do |save_memo|
     save_memo << memo_main.split(" ")
     end
   end
  end
 
  # 既存メモ編集
  def edit_memo 
   # 読み込むファイル名入力
   puts "編集したいメモのファイル名を入力してください"
   puts "※拡張子は除いてください"
   file_name = gets.chomp.to_s
   # ファイル名チェック
   @filename_checkflg = filename_search(file_name)
   # ファイルがなかった場合、処理を終了させる
   if @filename_checkflg == "false" then
     puts "ファイル名が見つかりませんでした。再度ファイル名を入力してください。"
   else
     # csvファイル読み込み
     read_memo = CSV.readlines("#{file_name}.csv")
     # メモ内容入力
     puts "メモしたい内容を記入してください"
     puts "完了したら「Ctrl + D」を押してください"
     puts "--------------------------------------"
     puts read_memo #既存の内容を表示
     memo_main = gets.to_s
     # 既存のメモに追記する
     CSV.open("#{file_name}.csv",'a') do |save_memo|
     save_memo << memo_main.split(" ")
     end
   end
  end
  
  # 入力されたファイル名の有無を確認する
  def filename_search(file_name)
   if File.exist?("#{file_name}.csv")
     # ファイルが見つかった場合、trueを返す
     @existflg = "true"
   else
     # ファイルが無かった場合、falseを返す
     @existflg = "false"
   end
   return @existflg
  end
end
 
 # インスタンス作成
 writememo = WirteMemo.new() 

 # メモタイプ選択
 puts "1(新規でメモを作成) 2(既存のメモ編集する)" 
 memo_type = gets.chomp.to_s

 if memo_type == "1" then
   # 新規メモ作成
   writememo.new_memo()
 elsif memo_type == "2" then
   # 既存メモ編集
   writememo.edit_memo()
 else
   # 1,2以外の値が入力された場合
   puts "値を1、もしくは2を指定してください"
 end

rescue
  puts $! # 例外オブジェクトを出力する
  puts $@ # 例外が発生した位置情報を出力する
  puts "例外エラーが発生しました"
end