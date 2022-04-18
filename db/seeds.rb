# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'creating seed'

User.destroy_all
Design.destroy_all

puts 'destroying all users and designs'

proyectos = ['RADIATOR GEN7 MAZDA NEW MODEL',
'CALIPER J34',
'FRONT BOLSTER RH/LH RACKS ',
'REAR BOLSTER RH/LH RACKS ',
'PYUD ENGINE RACK VERSION U',
'GMET6 ENGINE ASSY ',
'CONDENSADOR ',
'WINDSHIELD',
'SUBFRAME ASSY FRT NUEVO',
'GLASS ASSY FRT WINDSHIELD - RETRABAJO',
'GLASS ASSY RR WINDSHIELD - RETRABAJO',
'LINNING ASSY, ROOF - RETRABAJO',
'STEEL BASKET GMM',
'RADIATOR SUPPORT REINFIORCEMENT',
'STEEEL BASKET',
'CAÑUELA TRASERA',
'ASSY FASCIA FRONT 3001',
'ASSY FASCIA REAR 3002',
'STEERING GEAR TRAY']

clientes = [
  'HANON',
  'ZF',
  'IACNA',
  'MAZDA',
  'STELLANTIS',
  'SAINT GOBAIN',
  'HONDA',
  'GM',
  'ABC',
  'CONTEYOR'
  ]

status = ['activo', 'inactivo']

responsible = [
  'NIEVES ROJAS JOSE LUIS',
  'GARDUÑO DE PAZ HECTOR ENRIQUE',
  'HUERTA HERNANDEZ FRANCISCO',
  'RIVAS ALAMILLO MIGUEL']

iterator = 0
4.times do
  @new_user = User.create!(
    email: Faker::Internet.email,
    password: '123456',
    responsible: responsible[iterator]
  )
  10.times do
    @new_design = Design.create!(
      project_number: '22-' + (rand() * 10).to_i.to_s + (rand() * 10).to_i.to_s + (rand() * 10).to_i.to_s + '-R',
      client: clientes.sample,
      project_name: proyectos.sample,
      responsible: @new_user.responsible,
      revision: (rand() * 10).to_i,
      line: (rand() * 10).to_i,
      status: status.sample,
      autodesk_link: 'http://random.adress.com',
      server_path: '\\SERVERBIOIN\\RANDOM\\LOCATION\\PROJECTS\\ENGINEERING',
      user_id: @new_user.id
    )
  end
  iterator += 1
end

puts 'done'
