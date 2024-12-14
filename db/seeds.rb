# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'

User.destroy_all
Joboffer.destroy_all
Application.destroy_all

# Admin seeds
# Modify this email with yours}
# This will send an invitation email to become the admin user.

email_admin = "gcarlos.gabriel4@gmail.com"

User.invite!(email: email_admin ) do |u|
  u.skip_invitation = false # Ensure the invitation is sent
end
admin = User.first
admin[:admin] = true
admin.save!
puts "Admin invited"

# Users seeds

10.times do |i|
  if i % 2 == 0
    first_name = Faker::Name.male_first_name
  else
    first_name = Faker::Name.female_first_name
  end
  last_name = Faker::Name.last_name
  full_name = "#{first_name} #{last_name}"


  email = Faker::Internet.email(
    name: "#{full_name}",
    separators: ['.'],
    domain: "mail.com",
  )
  password = "123456"
  user =  User.new(
    name: full_name,
    email: email,
    password: password,
    password_confirmation: password,
    bio: Faker::Lorem.paragraphs(number: 3).join("\n"),
    admin: User.where(admin: true).count > 0 ? false : true,
    created_at: Time.now(), 
    updated_at: Time.now(),
    confirmed_at: Time.now(),
  )
  
  profile_picture_url = Faker::LoremFlickr.image(size: "300x300", search_terms: ['cats','dogs'])
  user.profile_picture.attach(io: URI.open(profile_picture_url), filename: 'profile.jpg', content_type: 'image/jpeg')

  #puts user.inspect

  if user.save!
    puts "Usuario #{user.name} creado exitosamente."
  else
    puts "Error al crear el usuario: #{user.errors.full_messages.join(", ")}"
  end
  
end


# Joboffer seeds
joboffers_data = [
  {
    title: 'Científico/a de Datos Senior',
    description: 'Buscamos un/a científico/a de datos senior para liderar proyectos de análisis de datos y machine learning. Deberás desarrollar modelos predictivos, realizar análisis exploratorios y presentar insights accionables a los equipos de negocio.',
    salary: 80000 # Ejemplo de salario
  },
  {
    title: 'Diseñador/a de Experiencia de Usuario (UX) Senior',
    description: 'Buscamos un/a diseñador/a UX senior para crear experiencias de usuario excepcionales. Deberás realizar investigaciones de usuarios, diseñar wireframes y prototipos, y colaborar con equipos de desarrollo.',
    salary: 70000 # Ejemplo de salario
  },
  {
    title: 'Ingeniero/a DevOps',
    description: 'Buscamos un/a ingeniero/a DevOps para automatizar nuestros procesos de desarrollo y despliegue. Deberás trabajar con herramientas como Docker, Kubernetes, y configurar infraestructuras en la nube.',
    salary: 90000 # Ejemplo de salario
  },
  {
    title: 'Especialista en Seguridad de la Información',
    description: 'Buscamos un/a especialista en seguridad de la información para proteger nuestros sistemas y datos. Deberás realizar evaluaciones de vulnerabilidades, implementar medidas de seguridad y responder a incidentes.',
    salary: 85000 # Ejemplo de salario
  },
  {
    title: 'Analista de Negocios Senior',
    description: 'Buscamos un/a analista de negocios senior para traducir las necesidades del negocio en requerimientos funcionales. Deberás colaborar con equipos de desarrollo y realizar análisis de impacto.',
    salary: 75000 # Ejemplo de salario
  },
  {
    title: 'Especialista en Marketing Digital',
    description: 'Buscamos un/a especialista en marketing digital para gestionar nuestras campañas en redes sociales y SEO. Deberás analizar el rendimiento de las campañas y optimizar los resultados.',
    salary: 60000 # Ejemplo de salario
  },
  {
    title: 'Desarrollador/a Backend Senior (Python)',
    description: 'Buscamos un/a desarrollador/a backend senior para construir APIs robustas y escalables. Deberás tener experiencia en frameworks como Django o Flask, y conocimientos en bases de datos relacionales y no relacionales.',
    salary: 95000 # Ejemplo de salario
  },
  {
    title: 'Especialista en Cloud Computing (AWS)',
    description: 'Buscamos un/a especialista en cloud computing (AWS) para diseñar y gestionar nuestra infraestructura en la nube. Deberás tener experiencia en servicios como EC2, S3, RDS, y Lambda.',
    salary: 88000 # Ejemplo de salario
  },
  {
    title: 'Ingeniero/a de Datos Senior',
    description: 'Buscamos un/a ingeniero/a de datos senior para construir y mantener nuestras infraestructuras de datos. Deberás tener experiencia en ETL, data warehousing y herramientas como Apache Spark.',
    salary: 92000 # Ejemplo de salario
  }
]

admin = User.find_by(admin: true)

joboffers_data.each do |job|
  job[:user_id] = admin.id # Asignar el ID del usuario administrador
  Joboffer.create!(job)
end

# Application seeds

joboffers = Joboffer.all

joboffers.each do |job|
  
  # Crear 3 candidatos para cada oferta de trabajo
  (1..5).each do |i|
    users = User.all
    candidate = users.sample
    application = Application.create!(
      user_id:candidate.id,
      joboffer_id: job.id,
      status_new: true,
    )
  end

end























