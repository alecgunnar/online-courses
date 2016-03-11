a = Assessment.new
a.name = 'Test Assignment'
a.description = 'This assignment will test the abilities of this application.'
a.user_id = 1
a.specs_file = 'specs.pdf'
a.due_date = Time.new.end_of_day
a.context = 182971
a.save!

td = TestDriver.new
td.assessment = a
td.name = 'driver.sh'
td.points = 10
td.save!

tdf = TestDriverFile.new
tdf.test_driver = td
tdf.name = 'hist_plot.pdf'
tdf.points = 10
tdf.save!

td = TestDriver.new
td.assessment = a
td.name = 'another_driver.sh'
td.points = 25
td.save!
