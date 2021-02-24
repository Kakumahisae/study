class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end

# DBのテーブルを作成する。どの種類のDBにするかはrails newの際に指定できる。
# 無指定ならデフォルトのDBである SQLite3 が使われる。
# DBテーブルが正しく作られているかは、db/schema.rbで確認できる。
