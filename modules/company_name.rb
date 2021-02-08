module CompanyName
  def set_company_name(name)
    self.company = name
  end

  def get_company_name
    company
  end

  protected

  attr_accessor :company
end
