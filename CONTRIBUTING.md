# Contributing to Lnastaqim

Thank you for your interest in contributing to Lnastaqim. Please review the following guidelines to ensure a smooth collaboration process.

---

## Branching Strategy

We follow a structured Git branching workflow:

- `main`: Production branch. Always stable, tested, and deployable.
- `dev`: Integration branch. Contains upcoming features and fixes ready for verification.
- `feature/<feature-name>`: Branches for developing new features, created from `dev`.
- `fix/<issue-name>`: Branches for bug fixes, created from `dev` or `main`.

---

## Getting Started

1. Fork the repository and clone your fork:
   ```bash
   git clone https://github.com/<your-username>/lnastaqim.git
   cd lnastaqim
   ```

2. Verify environment requirements:
   - Flutter SDK: 3.29.x
   - Dart SDK: ^3.7.2
   - Java: 17

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run code generation when updating models or adapters:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. Run the application using flavors:
   - Development Flavor:
     ```bash
     flutter run --flavor lnastaqim_dev -t lib/main_lnastaqim_dev.dart
     ```
   - Production Flavor:
     ```bash
     flutter run --flavor lnastaqim_prod -t lib/main_lnastaqim_prod.dart
     ```

---

## Commit Message Guidelines

We enforce the Conventional Commits specification:

```text
<type>(<scope>): <short summary>

[optional body]

[optional footer(s)]
```

### Allowed Types:
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation changes
- `style`: Changes that do not affect the meaning of the code (formatting, white-space)
- `refactor`: Code changes that neither fix a bug nor add a feature
- `perf`: Code changes that improve performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to tooling, dependencies, or CI/CD pipelines

### Examples:
```text
feat(quran): add ayah recitation repeat counter
fix(audio): handle audio interruption during phone calls
docs(readme): add flavor setup instructions
```

---

## Code Standards

Before opening a pull request, ensure all local checks pass:

1. Code is formatted:
   ```bash
   dart format --output=none --set-exit-if-changed .
   ```
2. Static analysis reports no errors:
   ```bash
   flutter analyze
   ```
3. Test suite passes:
   ```bash
   flutter test
   ```

---

## Submitting a Pull Request

1. Push your branch to your fork:
   ```bash
   git push origin feature/my-feature
   ```
2. Open a Pull Request targeting the `dev` branch.
3. Fill out the pull request template completely.
4. Ensure all automated GitHub Actions checks succeed.
5. Address any reviewer feedback promptly.
