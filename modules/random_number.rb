module RandomNumber
  def random_number
    "#{rand 0..999}-#{rand(36**3).to_s(36).upcase}"
  end
end
