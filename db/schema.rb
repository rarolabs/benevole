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

ActiveRecord::Schema.define(version: 20150707190963) do

  create_table "acoes", force: :cascade do |t|
    t.string   "nome",                  limit: 255
    t.integer  "instituicao_id",        limit: 4
    t.integer  "quantidade_voluntario", limit: 4
    t.date     "data_inicio"
    t.date     "data_fim"
    t.string   "horario",               limit: 255
    t.integer  "endereco_id",           limit: 4
    t.text     "descricao",             limit: 65535
    t.text     "observacao",            limit: 65535
    t.string   "state",                 limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "acoes", ["endereco_id"], name: "index_acoes_on_endereco_id", using: :btree
  add_index "acoes", ["instituicao_id"], name: "index_acoes_on_instituicao_id", using: :btree

  create_table "cidades", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.integer  "estado_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cidades", ["estado_id"], name: "index_cidades_on_estado_id", using: :btree

  create_table "enderecos", force: :cascade do |t|
    t.string   "cep",         limit: 255
    t.string   "logradouro",  limit: 255
    t.string   "complemento", limit: 255
    t.string   "numero",      limit: 255
    t.string   "bairro",      limit: 255
    t.integer  "cidade_id",   limit: 4
    t.integer  "usuario_id",  limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "enderecos", ["cidade_id"], name: "index_enderecos_on_cidade_id", using: :btree
  add_index "enderecos", ["usuario_id"], name: "index_enderecos_on_usuario_id", using: :btree

  create_table "estados", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.string   "sigla",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "instituicoes", force: :cascade do |t|
    t.string   "nome",        limit: 255
    t.string   "logo",        limit: 255
    t.text     "descricao",   limit: 65535
    t.string   "site",        limit: 255
    t.string   "email",       limit: 255
    t.integer  "endereco_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "papeis", force: :cascade do |t|
    t.string   "nome",          limit: 255
    t.string   "chave",         limit: 255
    t.string   "descricao",     limit: 255
    t.integer  "referencia_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participacoes", force: :cascade do |t|
    t.integer  "usuario_id", limit: 4
    t.integer  "acao_id",    limit: 4
    t.string   "state",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "participacoes", ["acao_id"], name: "index_participacoes_on_acao_id", using: :btree
  add_index "participacoes", ["usuario_id"], name: "index_participacoes_on_usuario_id", using: :btree

  create_table "permissoes", force: :cascade do |t|
    t.boolean  "can_read",    limit: 1
    t.boolean  "can_create",  limit: 1
    t.boolean  "can_update",  limit: 1
    t.boolean  "can_destroy", limit: 1
    t.boolean  "can_manage",  limit: 1
    t.string   "klass",       limit: 255
    t.integer  "papel_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissoes", ["papel_id"], name: "index_permissoes_on_papel_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,     null: false
    t.datetime "locked_at"
    t.integer  "papel_id",               limit: 4
    t.boolean  "root",                   limit: 1,   default: false
    t.integer  "instituicao_id",         limit: 4
    t.string   "nome",                   limit: 255
    t.string   "foto",                   limit: 255
    t.string   "telefone",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "endereco_id",            limit: 4
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["endereco_id"], name: "index_usuarios_on_endereco_id", using: :btree
  add_index "usuarios", ["papel_id"], name: "index_usuarios_on_papel_id", using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "acoes", "enderecos"
  add_foreign_key "acoes", "instituicoes"
  add_foreign_key "cidades", "estados"
  add_foreign_key "enderecos", "cidades"
  add_foreign_key "enderecos", "usuarios"
  add_foreign_key "participacoes", "acoes"
  add_foreign_key "participacoes", "usuarios"
  add_foreign_key "usuarios", "enderecos"
end
