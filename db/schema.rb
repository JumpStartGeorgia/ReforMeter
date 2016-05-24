# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160524100407) do

  create_table "expert_survey_translations", force: :cascade do |t|
    t.integer  "expert_survey_id", limit: 4,     null: false
    t.string   "locale",           limit: 255,   null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "summary",          limit: 65535
    t.text     "details",          limit: 65535
  end

  add_index "expert_survey_translations", ["expert_survey_id"], name: "index_expert_survey_translations_on_expert_survey_id", using: :btree
  add_index "expert_survey_translations", ["locale"], name: "index_expert_survey_translations_on_locale", using: :btree

  create_table "expert_surveys", force: :cascade do |t|
    t.integer  "quarter_id",       limit: 4,                         null: false
    t.decimal  "overall_score",              precision: 5, scale: 2, null: false
    t.decimal  "category1_score",            precision: 5, scale: 2, null: false
    t.decimal  "category2_score",            precision: 5, scale: 2, null: false
    t.decimal  "category3_score",            precision: 5, scale: 2, null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "overall_change",   limit: 4
    t.integer  "category1_change", limit: 4
    t.integer  "category2_change", limit: 4
    t.integer  "category3_change", limit: 4
  end

  add_index "expert_surveys", ["quarter_id"], name: "index_expert_surveys_on_quarter_id", using: :btree

  create_table "expert_surveys_experts", id: false, force: :cascade do |t|
    t.integer "expert_id",        limit: 4, null: false
    t.integer "expert_survey_id", limit: 4, null: false
  end

  create_table "expert_translations", force: :cascade do |t|
    t.integer  "expert_id",  limit: 4,     null: false
    t.string   "locale",     limit: 255,   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "name",       limit: 255
    t.text     "bio",        limit: 65535
  end

  add_index "expert_translations", ["expert_id"], name: "index_expert_translations_on_expert_id", using: :btree
  add_index "expert_translations", ["locale"], name: "index_expert_translations_on_locale", using: :btree

  create_table "experts", force: :cascade do |t|
    t.boolean  "is_active",                       default: true
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "experts", ["is_active"], name: "index_experts_on_is_active", using: :btree

  create_table "external_indicator_translations", force: :cascade do |t|
    t.integer  "external_indicator_id", limit: 4,     null: false
    t.string   "locale",                limit: 255,   null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "title",                 limit: 255
    t.text     "description",           limit: 65535
    t.text     "data",                  limit: 65535
  end

  add_index "external_indicator_translations", ["external_indicator_id"], name: "index_external_indicator_translations_on_external_indicator_id", using: :btree
  add_index "external_indicator_translations", ["locale"], name: "index_external_indicator_translations_on_locale", using: :btree

  create_table "external_indicators", force: :cascade do |t|
    t.integer  "indicator_type",    limit: 1
    t.integer  "chart_type",        limit: 1
    t.integer  "scale_type",        limit: 1
    t.integer  "min",               limit: 2
    t.integer  "max",               limit: 2
    t.boolean  "show_on_home_page",           default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "news", force: :cascade do |t|
    t.integer  "quarter_id",         limit: 4
    t.integer  "reform_id",          limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "news", ["quarter_id", "reform_id"], name: "index_news_on_quarter_id_and_reform_id", using: :btree

  create_table "news_translations", force: :cascade do |t|
    t.integer  "news_id",    limit: 4,     null: false
    t.string   "locale",     limit: 255,   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.string   "url",        limit: 255
  end

  add_index "news_translations", ["locale"], name: "index_news_translations_on_locale", using: :btree
  add_index "news_translations", ["news_id"], name: "index_news_translations_on_news_id", using: :btree
  add_index "news_translations", ["title"], name: "index_news_translations_on_title", using: :btree

  create_table "page_content_translations", force: :cascade do |t|
    t.integer  "page_content_id", limit: 4,     null: false
    t.string   "locale",          limit: 255,   null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "title",           limit: 255
    t.text     "content",         limit: 65535
  end

  add_index "page_content_translations", ["locale"], name: "index_page_content_translations_on_locale", using: :btree
  add_index "page_content_translations", ["page_content_id"], name: "index_page_content_translations_on_page_content_id", using: :btree

  create_table "page_contents", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "quarter_translations", force: :cascade do |t|
    t.integer  "quarter_id",          limit: 4,   null: false
    t.string   "locale",              limit: 255, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "summary_good",        limit: 255
    t.string   "summary_bad",         limit: 255
    t.string   "report_file_name",    limit: 255
    t.string   "report_content_type", limit: 255
    t.integer  "report_file_size",    limit: 4
    t.datetime "report_updated_at"
  end

  add_index "quarter_translations", ["locale"], name: "index_quarter_translations_on_locale", using: :btree
  add_index "quarter_translations", ["quarter_id"], name: "index_quarter_translations_on_quarter_id", using: :btree

  create_table "quarters", force: :cascade do |t|
    t.integer  "quarter",    limit: 1,                   null: false
    t.integer  "year",       limit: 2,                   null: false
    t.boolean  "is_public",              default: false
    t.string   "slug",       limit: 255,                 null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "quarters", ["slug"], name: "index_quarters_on_slug", unique: true, using: :btree
  add_index "quarters", ["year", "quarter"], name: "index_quarters_on_year_and_quarter", unique: true, using: :btree

  create_table "reform_colors", force: :cascade do |t|
    t.string   "hex",        limit: 255
    t.integer  "r",          limit: 2
    t.integer  "g",          limit: 2
    t.integer  "b",          limit: 2
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "reform_survey_translations", force: :cascade do |t|
    t.integer  "reform_survey_id",    limit: 4,     null: false
    t.string   "locale",              limit: 255,   null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "summary",             limit: 65535
    t.text     "government_summary",  limit: 65535
    t.text     "stakeholder_summary", limit: 65535
  end

  add_index "reform_survey_translations", ["locale"], name: "index_reform_survey_translations_on_locale", using: :btree
  add_index "reform_survey_translations", ["reform_survey_id"], name: "index_reform_survey_translations_on_reform_survey_id", using: :btree

  create_table "reform_surveys", force: :cascade do |t|
    t.integer  "quarter_id",                   limit: 4,                         null: false
    t.integer  "reform_id",                    limit: 4,                         null: false
    t.decimal  "government_overall_score",               precision: 5, scale: 2, null: false
    t.decimal  "government_category1_score",             precision: 5, scale: 2, null: false
    t.decimal  "government_category2_score",             precision: 5, scale: 2, null: false
    t.decimal  "government_category3_score",             precision: 5, scale: 2, null: false
    t.decimal  "government_category4_score",             precision: 5, scale: 2, null: false
    t.decimal  "stakeholder_overall_score",              precision: 5, scale: 2, null: false
    t.decimal  "stakeholder_category1_score",            precision: 5, scale: 2, null: false
    t.decimal  "stakeholder_category2_score",            precision: 5, scale: 2, null: false
    t.decimal  "stakeholder_category3_score",            precision: 5, scale: 2, null: false
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.integer  "government_overall_change",    limit: 4
    t.integer  "government_category1_change",  limit: 4
    t.integer  "government_category2_change",  limit: 4
    t.integer  "government_category3_change",  limit: 4
    t.integer  "government_category4_change",  limit: 4
    t.integer  "stakeholder_overall_change",   limit: 4
    t.integer  "stakeholder_category1_change", limit: 4
    t.integer  "stakeholder_category2_change", limit: 4
    t.integer  "stakeholder_category3_change", limit: 4
  end

  add_index "reform_surveys", ["quarter_id"], name: "index_reform_surveys_on_quarter_id", using: :btree
  add_index "reform_surveys", ["reform_id"], name: "index_reform_surveys_on_reform_id", using: :btree

  create_table "reform_translations", force: :cascade do |t|
    t.integer  "reform_id",   limit: 4,     null: false
    t.string   "locale",      limit: 255,   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",        limit: 255
    t.string   "summary",     limit: 255
    t.text     "methodology", limit: 65535
    t.string   "slug",        limit: 255
  end

  add_index "reform_translations", ["locale"], name: "index_reform_translations_on_locale", using: :btree
  add_index "reform_translations", ["name"], name: "index_reform_translations_on_name", using: :btree
  add_index "reform_translations", ["reform_id"], name: "index_reform_translations_on_reform_id", using: :btree
  add_index "reform_translations", ["slug"], name: "index_reform_translations_on_slug", using: :btree

  create_table "reforms", force: :cascade do |t|
    t.boolean  "is_active",                   default: true
    t.boolean  "is_highlight",                default: true
    t.string   "slug",            limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "reform_color_id", limit: 4
  end

  add_index "reforms", ["is_active"], name: "index_reforms_on_is_active", using: :btree
  add_index "reforms", ["is_highlight"], name: "index_reforms_on_is_highlight", using: :btree
  add_index "reforms", ["reform_color_id"], name: "index_reforms_on_reform_color_id", using: :btree
  add_index "reforms", ["slug"], name: "index_reforms_on_slug", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",                limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

end
