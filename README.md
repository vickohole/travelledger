# TravelLedger Django Project

Project ini adalah implementasi Django berdasarkan UI TravelLedger yang Anda lampirkan. Fokus utamanya:
- layout dashboard dan detail claim yang mengikuti tampilan UI referensi,
- struktur database untuk expense claim, approval, employee, vehicle, dan attachment,
- halaman list, detail, dan form create/edit,
- admin panel Django untuk maintenance data.

## Stack
- Python 3.11+
- Django 6.x
- SQLite (default, mudah untuk demo)
- Pillow (upload image receipt)

## Cara Menjalankan
```bash
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate
python manage.py seed_demo_data
python manage.py createsuperuser
python manage.py runserver
```

Buka:
- App: http://127.0.0.1:8000/
- Admin: http://127.0.0.1:8000/admin/

## Fitur yang Disediakan
1. Dashboard ringkasan claim.
2. Halaman `My Submissions`.
3. Halaman detail claim dengan layout mirip UI referensi.
4. Form create/edit claim, items, dan attachment.
5. Django admin untuk master data dan transaksi.
6. Seed data contoh sesuai data yang muncul pada screenshot.

## Struktur Project
```text
travelledger_django_project/
├── claims/
│   ├── management/commands/seed_demo_data.py
│   ├── migrations/
│   ├── templatetags/claim_extras.py
│   ├── admin.py
│   ├── forms.py
│   ├── models.py
│   ├── urls.py
│   └── views.py
├── config/
│   ├── settings.py
│   └── urls.py
├── media/
├── static/css/style.css
├── templates/
│   ├── base.html
│   └── claims/
│       ├── claim_detail.html
│       ├── claim_form.html
│       ├── claim_list.html
│       └── dashboard.html
├── database_schema.md
├── requirements.txt
└── manage.py
```

## Catatan Implementasi
- `document_id` disimpan di model `ExpenseClaim` agar mudah diintegrasikan dengan sistem finance / ERP.
- `ExpenseItem` dipisah agar satu claim bisa punya banyak baris expense.
- `ApprovalHistory` dipisah agar approval trail tetap tersimpan.
- `ClaimAttachment` mendukung banyak file receipt untuk satu claim.
- Default database menggunakan SQLite, tetapi model sudah siap dipindah ke PostgreSQL/MySQL jika dibutuhkan.

## Pengembangan Lanjutan yang Saya Sarankan
- autentikasi login per user/employee,
- approval workflow otomatis per level,
- export PDF real,
- API dengan Django REST Framework,
- notifikasi email/WhatsApp ketika status berubah,
- audit log dan role-based permission.
