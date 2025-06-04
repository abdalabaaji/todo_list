# Flutter Todo List App

A modern Todo List application built with Flutter and Supabase, featuring real-time updates and user authentication.

## Features

- User authentication (login/register)
- Create, read, update, and delete todos
- Real-time updates using Supabase
- Clean architecture with BLoC pattern
- Modern Material Design UI

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- Supabase account

### Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/todo_list.git
cd todo_list
```

2. Install dependencies:
```bash
flutter pub get
```

3. Create a `.env` file in the root directory with your Supabase credentials:
```
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

4. Run the app:
```bash
flutter run
```

## Architecture

The project follows clean architecture principles and uses the BLoC pattern for state management:

- `lib/features/` - Contains feature-specific code
  - `auth/` - Authentication related code
  - `todo/` - Todo management related code
- `lib/core/` - Core utilities and constants

## Dependencies

- `flutter_bloc` - State management
- `supabase_flutter` - Backend and authentication
- `go_router` - Navigation
- `flutter_dotenv` - Environment variables management

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
