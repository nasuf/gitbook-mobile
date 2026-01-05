# GitBook Mobile App - Project Plan

## Project Overview

A Flutter-based mobile application for iOS and Android that provides full browsing and editing capabilities for GitBook content management.

---

## Tech Stack

| Component | Technology |
|-----------|------------|
| Framework | Flutter 3.32+ |
| Language | Dart 3.8+ |
| State Management | Riverpod 2.x |
| HTTP Client | Dio |
| Local Storage | Hive / SQLite (drift) |
| Markdown Editor | flutter_quill / Super Editor |
| Markdown Renderer | flutter_markdown |
| Authentication | OAuth 2.0 / API Token |
| Navigation | go_router |

---

## Architecture

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── config/              # App configuration
│   ├── constants/           # Constants and enums
│   ├── errors/              # Error handling
│   ├── network/             # Dio client, interceptors
│   ├── storage/             # Local storage abstraction
│   └── utils/               # Utility functions
├── data/
│   ├── datasources/         # Remote & local data sources
│   │   ├── remote/
│   │   └── local/
│   ├── models/              # Data models (JSON serializable)
│   └── repositories/        # Repository implementations
├── domain/
│   ├── entities/            # Business entities
│   ├── repositories/        # Repository interfaces
│   └── usecases/            # Business logic
├── presentation/
│   ├── providers/           # Riverpod providers
│   ├── screens/             # Screen widgets
│   ├── widgets/             # Reusable widgets
│   └── theme/               # App theming
└── l10n/                    # Localization
```

---

## Features & Implementation Plan

### Phase 1: Foundation (Core Infrastructure)

#### 1.1 Project Setup
- [x] Initialize Flutter project
- [x] Configure pubspec.yaml with dependencies
- [x] Set up project folder structure
- [x] Configure analysis_options.yaml
- [x] Set up environment configuration (dev/staging/prod)

#### 1.2 Network Layer
- [x] Implement Dio HTTP client wrapper
- [x] Create request/response interceptors
- [x] Implement error handling middleware
- [x] Add logging interceptor for debugging
- [x] Implement retry logic for failed requests

#### 1.3 GitBook API Client
- [x] Define API endpoints constants
- [x] Implement authentication endpoints
  - [x] POST /oauth/token
  - [x] Token refresh logic
- [x] Implement Organizations API
  - [x] GET /orgs - List organizations
  - [x] GET /orgs/{orgId} - Get organization details
- [x] Implement Spaces API
  - [x] GET /orgs/{orgId}/spaces - List spaces
  - [x] GET /spaces/{spaceId} - Get space details
  - [x] POST /spaces - Create space
  - [x] PATCH /spaces/{spaceId} - Update space
  - [x] DELETE /spaces/{spaceId} - Delete space
- [x] Implement Pages/Content API
  - [x] GET /spaces/{spaceId}/content - List pages
  - [x] GET /spaces/{spaceId}/content/path/{path} - Get page by path
  - [x] POST /spaces/{spaceId}/content - Create page
  - [x] PATCH /spaces/{spaceId}/content/{pageId} - Update page
  - [x] DELETE /spaces/{spaceId}/content/{pageId} - Delete page
- [x] Implement Change Requests API
  - [x] GET /spaces/{spaceId}/change-requests - List change requests
  - [x] POST /spaces/{spaceId}/change-requests - Create change request
  - [x] GET /spaces/{spaceId}/change-requests/{crId} - Get change request
  - [x] POST /spaces/{spaceId}/change-requests/{crId}/merge - Merge
- [x] Implement Search API
  - [x] GET /orgs/{orgId}/search - Global search
  - [x] GET /spaces/{spaceId}/search - Space search

#### 1.4 Local Storage
- [x] Set up Hive for lightweight storage
- [x] Implement secure storage for tokens
- [x] Set up SQLite (drift) for content caching
- [x] Define database schema for offline content
- [x] Implement cache invalidation strategy

---

### Phase 2: Authentication & User Management

#### 2.1 Authentication Flow
- [x] Implement login screen UI
- [x] OAuth 2.0 web view integration
- [x] API token input option
- [x] Token storage (secure storage)
- [x] Auto token refresh mechanism
- [x] Logout functionality
- [x] Session expiry handling

#### 2.2 User Profile
- [x] Fetch current user info
- [x] Display user profile screen
- [x] Organization switcher
- [x] Account settings

---

### Phase 3: Content Browsing

#### 3.1 Home Screen
- [ ] Organizations list view
- [ ] Recent spaces quick access
- [ ] Search bar (global search)
- [ ] Pull-to-refresh

#### 3.2 Spaces Management
- [ ] Spaces list view (grid/list toggle)
- [ ] Space detail view
- [ ] Space settings view
- [ ] Create new space
- [ ] Delete space (with confirmation)
- [ ] Space search/filter

#### 3.3 Pages Navigation
- [ ] Table of contents (tree view)
- [ ] Page list view
- [ ] Breadcrumb navigation
- [ ] Page search within space

#### 3.4 Markdown Rendering
- [ ] Basic markdown rendering
- [ ] Code block syntax highlighting
- [ ] Table rendering
- [ ] Image loading and caching
- [ ] Link handling (internal/external)
- [ ] LaTeX/Math rendering (optional)
- [ ] Mermaid diagram rendering (optional)
- [ ] Custom GitBook blocks rendering
  - [ ] Hints (info, warning, danger, success)
  - [ ] Tabs
  - [ ] Expandable sections
  - [ ] Embeds

---

### Phase 4: Content Editing

#### 4.1 Markdown Editor
- [ ] Rich text editor integration (flutter_quill or Super Editor)
- [ ] Markdown toolbar
  - [ ] Bold, Italic, Strikethrough
  - [ ] Headings (H1-H6)
  - [ ] Lists (ordered, unordered, checklist)
  - [ ] Links
  - [ ] Code (inline and block)
  - [ ] Quotes
  - [ ] Tables
  - [ ] Horizontal rule
- [ ] Live preview mode (split view)
- [ ] Source mode (raw markdown)
- [ ] Auto-save draft
- [ ] Undo/Redo support

#### 4.2 Media Management
- [ ] Image picker (camera/gallery)
- [ ] Image upload to GitBook
- [ ] File attachment support
- [ ] Image compression before upload

#### 4.3 Page Management
- [ ] Create new page
- [ ] Edit existing page
- [ ] Delete page (with confirmation)
- [ ] Reorder pages (drag & drop)
- [ ] Move page to different location
- [ ] Duplicate page

---

### Phase 5: Change Requests (Git-like Workflow)

#### 5.1 Change Request Management
- [ ] List change requests
- [ ] View change request details
- [ ] Create new change request
- [ ] Edit in change request context
- [ ] View diff/changes
- [ ] Add comments to change request
- [ ] Merge change request
- [ ] Close/discard change request

#### 5.2 Review Flow
- [ ] Request review
- [ ] Approve changes
- [ ] Request changes
- [ ] Comment on specific content

---

### Phase 6: Offline Support

#### 6.1 Content Caching
- [ ] Cache spaces metadata
- [ ] Cache page content
- [ ] Cache images locally
- [ ] Background sync when online

#### 6.2 Offline Editing
- [ ] Queue edits when offline
- [ ] Sync indicator UI
- [ ] Conflict detection
- [ ] Conflict resolution UI
- [ ] Retry failed syncs

#### 6.3 Sync Management
- [ ] Manual sync trigger
- [ ] Sync status per space
- [ ] Clear cache option
- [ ] Storage usage display

---

### Phase 7: Search & Discovery

#### 7.1 Search Features
- [ ] Global search across organizations
- [ ] Space-specific search
- [ ] Full-text content search
- [ ] Search history
- [ ] Search suggestions
- [ ] Filter by content type

#### 7.2 Recent & Favorites
- [ ] Recently viewed pages
- [ ] Bookmarked pages
- [ ] Quick access shortcuts

---

### Phase 8: Settings & Preferences

#### 8.1 App Settings
- [x] Theme selection (Light/Dark/System) - Basic implementation
- [ ] Editor preferences
  - [ ] Default edit mode
  - [ ] Auto-save interval
  - [ ] Font size
- [ ] Notification settings
- [ ] Language selection
- [ ] Cache management

#### 8.2 About & Support
- [ ] App version info
- [ ] Open source licenses
- [ ] Privacy policy link
- [ ] Terms of service link
- [ ] Feedback/Support link

---

### Phase 9: Polish & Enhancement

#### 9.1 UI/UX Enhancement
- [ ] Skeleton loading states
- [ ] Empty states design
- [ ] Error states design
- [ ] Haptic feedback
- [ ] Smooth animations
- [ ] Gesture navigation

#### 9.2 Accessibility
- [ ] Screen reader support
- [ ] Dynamic text sizing
- [ ] Color contrast compliance
- [ ] Keyboard navigation

#### 9.3 Performance Optimization
- [ ] Lazy loading for lists
- [ ] Image lazy loading
- [ ] Memory optimization
- [ ] Startup time optimization

---

### Phase 10: Platform Specific

#### 10.1 iOS Specific
- [ ] iOS app icons
- [ ] Launch screen
- [ ] Deep linking configuration
- [ ] Share extension (optional)
- [ ] Widget support (optional)

#### 10.2 Android Specific
- [ ] Android app icons (adaptive)
- [ ] Splash screen
- [ ] Deep linking configuration
- [ ] Share intent handling (optional)
- [ ] Home screen widget (optional)

---

## Dependencies (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0

  # Networking
  dio: ^5.4.0
  retrofit: ^4.0.0

  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_secure_storage: ^9.0.0
  drift: ^2.14.0
  sqlite3_flutter_libs: ^0.5.0

  # Navigation
  go_router: ^13.0.0

  # Markdown
  flutter_markdown: ^0.6.18
  markdown: ^7.1.1
  flutter_quill: ^9.0.0

  # UI Components
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.0
  shimmer: ^3.0.0

  # Code Highlighting
  flutter_highlight: ^0.7.0

  # Utilities
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  equatable: ^2.0.5
  intl: ^0.18.1
  url_launcher: ^6.2.0
  share_plus: ^7.2.0
  image_picker: ^1.0.0
  path_provider: ^2.1.0
  connectivity_plus: ^5.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  # Code Generation
  build_runner: ^2.4.0
  freezed: ^2.4.5
  json_serializable: ^6.7.1
  retrofit_generator: ^8.0.0
  riverpod_generator: ^2.3.0
  hive_generator: ^2.0.1
  drift_dev: ^2.14.0

  # Linting
  flutter_lints: ^3.0.0

  # Testing
  mockito: ^5.4.0
  mocktail: ^1.0.0
```

---

## API Endpoints Reference

Base URL: `https://api.gitbook.com/v1`

### Authentication
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | /oauth/token | Get access token |

### Organizations
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /orgs | List organizations |
| GET | /orgs/{orgId} | Get organization |
| GET | /orgs/{orgId}/members | List members |

### Spaces
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /orgs/{orgId}/spaces | List spaces |
| POST | /orgs/{orgId}/spaces | Create space |
| GET | /spaces/{spaceId} | Get space |
| PATCH | /spaces/{spaceId} | Update space |
| DELETE | /spaces/{spaceId} | Delete space |

### Content
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /spaces/{spaceId}/content | List content |
| GET | /spaces/{spaceId}/content/path/{path} | Get by path |
| POST | /spaces/{spaceId}/content | Create page |
| PUT | /spaces/{spaceId}/content/{pageId} | Update page |
| DELETE | /spaces/{spaceId}/content/{pageId} | Delete page |

### Change Requests
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /spaces/{spaceId}/change-requests | List CRs |
| POST | /spaces/{spaceId}/change-requests | Create CR |
| GET | /spaces/{spaceId}/change-requests/{id} | Get CR |
| POST | /spaces/{spaceId}/change-requests/{id}/merge | Merge CR |

---

## Milestones

### MVP (Minimum Viable Product)
- [ ] Authentication (login/logout)
- [ ] View organizations and spaces
- [ ] Browse and read pages
- [ ] Basic markdown rendering
- [ ] Basic page editing
- [ ] Create/delete pages

### V1.0
- [ ] Full Change Request workflow
- [ ] Offline content viewing
- [ ] Search functionality
- [ ] Image upload
- [ ] Complete markdown support

### V1.1+
- [ ] Offline editing with sync
- [ ] Advanced search with filters
- [ ] Widgets and extensions
- [ ] Collaboration features

---

## Testing Strategy

### Unit Tests
- [x] API client tests
- [x] Network interceptor tests (error, auth, retry)
- [x] Data model tests (serialization/deserialization)
- [x] Secure storage tests
- [x] Local storage tests (Hive, Drift database, cache manager, local datasource)
- [x] Auth repository tests
- [x] Auth and user use case tests
- [x] Auth and user provider tests
- [ ] Repository tests
- [ ] Provider tests

### Widget Tests
- [ ] Screen widget tests
- [ ] Component widget tests

### Integration Tests
- [ ] Authentication flow
- [ ] Content browsing flow
- [ ] Edit and save flow
- [ ] Offline sync flow

---

## Notes

- All API calls require Bearer token authentication
- Rate limiting: Monitor API usage to avoid exceeding limits
- Content format: GitBook uses a custom JSON format internally, with markdown as export format
- Conflict handling: Implement last-write-wins or manual merge for offline conflicts
