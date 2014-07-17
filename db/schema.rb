# This file is auto-generated from the current state of the database. Instead of editing this file,
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 14) do

  create_table "groups", :force => true do |t|
    t.string   "group_name"
    t.text     "group_detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["group_name"], :name => "uniq_group_name", :unique => true

  create_table "judgments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pool_entry_id"
    t.integer  "relevance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pool_entries", :force => true do |t|
    t.integer  "pool_id"
    t.integer  "record_id"
    t.integer  "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id"
  end

  add_index "pool_entries", ["pool_id", "record_id", "topic_id"], :name => "uniq_pool_topic_record", :unique => true

  create_table "pools", :force => true do |t|
    t.string "pool_name",  :limit => nil
    t.text   "comments"
    t.date   "created_at"
  end

  create_table "qrel_entries", :force => true do |t|
    t.integer "qrel_id"
    t.integer "user_id"
    t.integer "topic_id"
  end

  create_table "qrels", :force => true do |t|
    t.integer "pool_id"
    t.string  "name"
    t.string  "comments"
  end

  create_table "records", :force => true do |t|
    t.integer "figure_id"
    t.string  "figure_url"
    t.text    "caption"
    t.string  "title",            :limit => 512
    t.integer "pmid"
    t.string  "article_url"
    t.string  "image_url"
    t.string  "image_local_name"
    t.text    "full_caption"
    t.text    "parsed_caption"
    t.text    "text_modality"
    t.string  "caption_modality"
    t.string  "visual_modality"
  end

  add_index "records", ["figure_id"], :name => "idx_record_figure_id"
  add_index "records", ["image_local_name"], :name => "idx_record_image_local_name"
  add_index "records", ["text_modality"], :name => "idx_text_modality"

  create_table "results", :force => true do |t|
    t.integer  "run_name_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.decimal  "num_q"
    t.decimal  "num_ret"
    t.decimal  "num_rel"
    t.decimal  "num_rel_ret"
    t.decimal  "map"
    t.decimal  "gm_ap"
    t.decimal  "r_prec"
    t.decimal  "bpref"
    t.decimal  "recip_rank"
    t.decimal  "ircl_prn_0_00"
    t.decimal  "ircl_prn_0_10"
    t.decimal  "ircl_prn_0_20"
    t.decimal  "ircl_prn_0_30"
    t.decimal  "ircl_prn_0_40"
    t.decimal  "ircl_prn_0_50"
    t.decimal  "ircl_prn_0_60"
    t.decimal  "ircl_prn_0_70"
    t.decimal  "ircl_prn_0_80"
    t.decimal  "ircl_prn_0_90"
    t.decimal  "ircl_prn_1_00"
    t.decimal  "p5"
    t.decimal  "p10"
    t.decimal  "p15"
    t.decimal  "p20"
    t.decimal  "p30"
    t.decimal  "p100"
    t.decimal  "p200"
    t.decimal  "p500"
    t.decimal  "p1000"
  end

  create_table "run_entries", :force => true do |t|
    t.integer "topic_id"
    t.integer "record_id"
    t.integer "rank"
    t.float   "score"
    t.integer "run_name_id"
  end

  add_index "run_entries", ["topic_id"], :name => "idx_run_entries_topic_id"
  add_index "run_entries", ["record_id"], :name => "idx_run_entry_record_id"
  add_index "run_entries", ["run_name_id"], :name => "idx_run_entry_run_name_id"
  add_index "run_entries", ["topic_id", "record_id", "run_name_id"], :name => "uniq_run_entries", :unique => true

  create_table "run_entries_bak", :force => true do |t|
    t.integer "topic_id"
    t.integer "record_id"
    t.integer "rank"
    t.float   "score"
    t.integer "run_name_id"
  end

  create_table "run_entries_stats", :id => false, :force => true do |t|
    t.integer "rn_id"
    t.text    "file_name"
    t.string  "run_name"
    t.integer "count"
    t.integer "group_id"
    t.string  "group_name"
    t.integer "distinct_topics"
    t.integer "run_name_id"
  end

  create_table "run_names", :force => true do |t|
    t.integer  "group_id"
    t.text     "file_name"
    t.string   "language"
    t.boolean  "visual"
    t.boolean  "mixed"
    t.boolean  "text"
    t.boolean  "automatic"
    t.boolean  "manual"
    t.boolean  "feedback"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "run_name"
    t.string   "training_data"
  end

  add_index "run_names", ["file_name"], :name => "uniq_file_name", :unique => true

  create_table "run_names_bak", :force => true do |t|
    t.integer  "group_id"
    t.text     "file_name"
    t.string   "language"
    t.boolean  "visual"
    t.boolean  "mixed"
    t.boolean  "text"
    t.boolean  "automatic"
    t.boolean  "manual"
    t.boolean  "feedback"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "run_name"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "topic_sample_images", :force => true do |t|
    t.string  "image_name"
    t.integer "topic_id"
  end

  create_table "topic_sets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.integer  "iclef_topic_number"
    t.integer  "topic_set_id"
    t.text     "topic_text"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
