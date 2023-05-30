Service.destroy_all
Company.destroy_all
Category.destroy_all

company = Company.create!(
  name: 'Legenda',
  address: 'Repina-38',
  phone: '+375291234567',
  description: 'Billiard club in Grodno'
)

admin = User.create!(
  email: "#{ENV["ADMIN_EMAIL"]}",
  name: 'Administrator',
  password:  "#{ENV["ADMIN_PASSWORD"]}",
  confirmed_at: DateTime.now,
  role: 1,
  phone: '+3751234567'
)

category_active = Category.create!(name: 'Active')
category_relax = Category.create!(name: 'Relax')

Service.create!([{
                   name: 'Pool',
                   description: 'Pool is a classification of cue sports played on a table with six pockets along the
                                 rails, into which balls are deposited.',
                   duration: 60,
                   price: 11,
                   company_id: company.id,
                   quantity: 5,
                   opening_time: '16:00',
                   closing_time: '02:00',
                   category_id: category_active.id
                 },
                 {
                   name: 'Russian billiard',
                   description: 'Russian pyramid, also known as Russian billiards, is a form of billiards played on a
                                 large billiard table with narrow pockets.',
                   duration: 60,
                   price: 11,
                   company_id: company.id,
                   quantity: 8,
                   opening_time: '16:00',
                   closing_time: '02:00',
                   category_id: category_active.id
                 },
                 {
                   name: 'Table tennis',
                   description: 'Table tennis, also known as ping-pong and whiff-whaff, is a racket sport derived from
                                  tennis but distinguished by its playing surface being atop a stationary table, rather
                                  than the court on which players stand.',
                   duration: 60,
                   price: 8,
                   company_id: company.id,
                   quantity: 1,
                   opening_time: '16:00',
                   closing_time: '02:00',
                   category_id: category_active.id
                 },
                 {
                   name: 'Massage chair',
                   description: 'A place in our club where you can just relax.',
                   duration: 15,
                   price: 5,
                   company_id: company.id,
                   quantity: 1,
                   opening_time: '16:00',
                   closing_time: '02:00',
                   category_id: category_relax.id
                 },
                 {
                   name: 'Sport translation',
                   description: 'You can book to view various sporting events on the big screen.',
                   duration: 60,
                   price: 10,
                   company_id: company.id,
                   quantity: 1,
                   opening_time: '16:00',
                   closing_time: '02:00',
                   category_id: category_relax.id
                 }])
Service.reindex
