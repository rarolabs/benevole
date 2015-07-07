class ConviteMailer < ActionMailer::Base
  default from: "naoresponda@rarolabs.com.br"
  layout 'mailer'

  def enviar(acao_id, email)
    @acao = Acao.find(acao_id)
    mail :to => email, :subject => "[#{acao.instituicao.to_s}] - #{acao.nome}"
  end
end