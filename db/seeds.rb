root                            = User.new
root.email                      = 'root@wmich.edu'
root.password                   = '$iamroot'
root.password_confirmation = '$iamroot'
# root.skip_confirmation!

root.save!