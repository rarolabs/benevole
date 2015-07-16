class InstituicaoCrud < RaroCrud
  titulo "Instituições"

  link_superior "Nova Instituição", id: "novo-button", icon: "plus", link: "new"
  
  ordenar_por :nome
  itens_por_pagina 20

  campo_tabela :nome,  label: "Nome"
  campo_tabela :logo,  label: "Logo"
  campo_tabela :descricao,  label: "Descricao"

  campo_formulario :nome,  label: "Nome"
  campo_formulario :logo,  label: "Logo"
  campo_formulario :descricao,  label: "Descricao"
  campo_formulario :site,  label: "Site"
  campo_formulario :email,  label: "Email"
  adicionar_endereco

  campo_visualizacao :nome,  label: "Nome"
  campo_visualizacao :logo,  label: "Logo"
  campo_visualizacao :descricao,  label: "Descricao"
  campo_visualizacao :site,  label: "Site"
  campo_visualizacao :email,  label: "Email"
  campo_visualizacao :endereco,  label: "Endereco"

  campo_busca :nome,  label: "Nome"
end