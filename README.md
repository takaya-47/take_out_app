# usersテーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| shop_name          | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| category_id        | integer | null: false               |
| prefecture_id      | integer | null: false               |
| address            | string  | null: false               |
| business_hours     | string  | null: false               |
| holiday            | string  | null: false               |
| phone_number       | string  | null: false               |

### Association
- has_many :menus


# menusテーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| name    | string     | null: false                    |
| price   | integer    | null: false                    |
| explain | text       | null: false                    |
| user    | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_many :orders


# ordersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| menu   | references | null: false, foreign_key: true |


### Association
- belongs_to :menu
- has_one :order_detail


# order_detailsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| quantity        | integer    | null: false                    |
| total_price     | integer    | null: false                    |
| last_name       | string     | null: false                    |
| first_name      | string     | null: false                    |
| last_name_kana  | string     | null: false                    |
| first_name_kana | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| address         | string     | null: false                    |
| phone_number    | string     | null: false                    |
| visit_time_id   | integer    | null: false                    |
| order           | references | null: false, foreign_key: true |


### Association
- belongs_to :order