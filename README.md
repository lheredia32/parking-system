# Parking System

Sistema de gestión de parqueadero con autenticación, control de vehículos y roles de usuario.

## Características

- **Autenticación**: Sistema custom con cookies (no Devise)
- **Roles de usuario**: Empleado (0) y Administrador (1)
- **Gestión de vehículos**: Registro de ingreso, salida y cálculo automático de precio
- **Búsqueda por placa**: Modal con turbo frames
- **Exportación PDF**: Reporte de vehículos con tabla formateada
- **Interfaz**: Theme oscuro con TailwindCSS, reloj digital y estilos retro-futuristas

## Tecnologías

- **Framework**: Rails 8.0.0
- **Ruby**: 3.2.0
- **Base de datos**: SQLite
- **Frontend**: Hotwire (Turbo + Stimulus), TailwindCSS
- **PDF**: Prawn + prawn-table

## Precios

| Tipo | Precio/hora | Primera media hora |
|------|-------------|-------------------|
| Motocicleta | $3,500 | Gratis |
| Carro | $5,000 | Gratis |
| Bicicleta | $2,500 (flat) | Gratis |

## Roles

- **Empleado**: Puede registrar vehículos, registrar salida, ver sus propios vehículos
- **Administrador**: Todas las permisos de empleado + gestionar usuarios, ver todos los registros, exportar PDF

## Rutas principales

| Ruta | Descripción |
|------|-------------|
| `/` | Dashboard principal |
| `/vehicles` | Lista de vehículos del usuario |
| `/vehicles/search` | Búsqueda por placa |
| `/vehicles/records_by_user` | Todos los registros (admin) |
| `/vehicles/:id/exit` | Registrar salida |
| `/admin/users` | Gestión de usuarios (admin) |
| `/profile` | Perfil del usuario |

## Instalación

```bash
# Instalar dependencias
bundle install

# Crear base de datos
bin/rails db:create db:migrate

# Iniciar servidor
bin/dev
```

## Desarrollo

```bash
# Linting
bundle exec rubocop

# Tests
bin/rails test

# Seguridad
bundle exec brakeman
```

## Estructura de modelos

```
User (id, email, password_digest, role, created_at)
├── Profile (name, last_name, phone_number)
├── Vehicle (plate_number, vehicle_type, entry_time, exit_time)
└── Session (user_id, user_agent, ip_address)
```

## Licencia

MIT - by Heredium