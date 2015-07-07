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
    t.string   "nome"
    t.integer  "instituicao_id"
    t.integer  "quantidade_voluntario"
    t.date     "data_inicio"
    t.date     "data_fim"
    t.string   "horario"
    t.integer  "endereco_id"
    t.text     "descricao"
    t.text     "observacao"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "acoes", ["endereco_id"], name: "index_acoes_on_endereco_id"
  add_index "acoes", ["instituicao_id"], name: "index_acoes_on_instituicao_id"

  create_table "cidades", force: :cascade do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cidades", ["estado_id"], name: "index_cidades_on_estado_id"

  create_table "enderecos", force: :cascade do |t|
    t.string   "cep"
    t.string   "logradouro"
    t.string   "complemento"
    t.string   "numero"
    t.string   "bairro"
    t.integer  "cidade_id"
    t.integer  "usuario_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "enderecos", ["cidade_id"], name: "index_enderecos_on_cidade_id"
  add_index "enderecos", ["usuario_id"], name: "index_enderecos_on_usuario_id"

  create_table "estados", force: :cascade do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instituicoes", force: :cascade do |t|
    t.string   "nome"
    t.string   "logo"
    t.text     "descricao"
    t.string   "site"
    t.string   "email"
    t.integer  "endereco_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "papeis", force: :cascade do |t|
    t.string   "nome"
    t.string   "chave"
    t.string   "descricao"
    t.integer  "referencia_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participacoes", force: :cascade do |t|
    t.integer  "usuario_id"
    t.integer  "acao_id"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "participacoes", ["acao_id"], name: "index_participacoes_on_acao_id"
  add_index "participacoes", ["usuario_id"], name: "index_participacoes_on_usuario_id"

  create_table "permissoes", force: :cascade do |t|
    t.boolean  "can_read"
    t.boolean  "can_create"
    t.boolean  "can_update"
    t.boolean  "can_destroy"
    t.boolean  "can_manage"
    t.string   "klass"
    t.integer  "papel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissoes", ["papel_id"], name: "index_permissoes_on_papel_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.datetime "locked_at"
    t.integer  "papel_id"
    t.boolean  "root",                   default: false
    t.integer  "instituicao_id"
    t.string   "nome"
    t.string   "foto"
    t.string   "telefone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "endereco_id"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true
  add_index "usuarios", ["endereco_id"], name: "index_usuarios_on_endereco_id"
  add_index "usuarios", ["papel_id"], name: "index_usuarios_on_papel_id"
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true

end
