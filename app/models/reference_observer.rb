class ReferenceObserver < ActiveRecord::Observer

  observe :'ActiveRecord::Base'

  def before_save(record)
    if record.respond_to?(:instituicao_id) and Usuario.current.present? and Usuario.current.instituicao_id.present?
      record.instituicao_id = Usuario.current.instituicao_id
    end
  end

  def before_validation(record)
    before_save(record)
  end

end