class ConviteMailer < ActionMailer::Base
  default from: "naoresponda@rarolabs.com.br"
  layout 'mailer'

  def enviar(participacao_id)
    @participacao = Participacao.find(participacao_id)
    @acao = @participacao.acao
    mail :to => @participacao.usuario.email, :subject => "[#{@acao.instituicao.to_s}] - #{@acao.nome}"
  end
end