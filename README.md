# DevOps Lab 1 — Trải nghiệm DevOps Workflow End-to-End

> **Học phần:** Vận hành & Bảo trì Phần mềm với DevOps  
> **Bài thực hành:** Lab 1 — Tổng quan về Vận hành & Bảo trì Phần mềm (My First CI/CD Pipeline)

---

## 👨‍🎓 Thông tin sinh viên

- **Họ và tên:** Ma Quốc Đan
- **Mã số sinh viên (MSSV):** DTC235180041
- **Kho lưu trữ (Repository):** [https://github.com/quocdan31/devops-lab1-mysite](https://github.com/quocdan31/devops-lab1-mysite)
- **Website trực tuyến (GitHub Pages):** [https://quocdan31.github.io/devops-lab1-mysite/](https://quocdan31.github.io/devops-lab1-mysite/)

---

## 🎯 Mục tiêu bài Lab

1. Trải nghiệm trọn vẹn vòng đời DevOps: **Plan → Code → Build → Test → Deploy → Monitor**.
2. Xây dựng và cấu hình CI/CD pipeline tự động hóa với **GitHub Actions**.
3. Triển khai website tĩnh lên **GitHub Pages** với URL thật có thể truy cập toàn cầu.
4. Nắm vững sự khác biệt giữa quy trình DevOps tự động và phương pháp vận hành thủ công truyền thống.

---

## 📁 Cấu trúc thư mục dự án

```text
devops-lab1-mysite/
├── .github/
│   └── workflows/
│       └── deploy.yml       # Định nghĩa CI/CD Pipeline (GitHub Actions)
├── index.html               # Trang web Portfolio cá nhân
└── README.md                # Báo cáo và thông tin sinh viên thực hiện
```

---

## ⚙️ Chi tiết CI/CD Pipeline (`deploy.yml`)

Pipeline tự động kích hoạt mỗi khi có mã nguồn được `push` lên nhánh `main`:

1. **Trigger:** Lắng nghe sự kiện `push` trên nhánh `main` (hoặc chạy thủ công qua `workflow_dispatch`).
2. **Environment:** Chạy trên runner máy ảo `ubuntu-latest`.
3. **Các bước thực thi (Steps):**
   - **Step 1: Checkout Code:** Kéo mã nguồn mới nhất về runner (`actions/checkout@v4`).
   - **Step 2: Validate HTML:** Kiểm tra sự tồn tại và tính hợp lệ dung lượng của file `index.html`.
   - **Step 3: Deploy to GitHub Pages:** Tự động đóng gói và xuất bản lên nhánh `gh-pages` bằng action `peaceiris/actions-gh-pages@v3`.

---

## 📊 So sánh quy trình: Truyền thống vs DevOps

| Tiêu chí | Quy trình Thủ công (Traditional) | Quy trình DevOps (CI/CD Pipeline) |
| :--- | :--- | :--- |
| **Cách triển khai** | Nén zip, kết nối FTP/SSH, upload đè file thủ công | `git push origin main` → Pipeline tự động toàn bộ |
| **Thời gian thực hiện** | 15 – 30 phút | ~10 – 30 giây |
| **Người thực hiện** | Kỹ sư/Dev thao tác bằng tay | GitHub Actions Runner (tự động hóa 100%) |
| **Khả năng sai sót** | Cao (quên file, phân quyền sai, nhầm môi trường) | Không — chạy chuẩn xác và nhất quán theo kịch bản YAML |
| **Rollback khi lỗi** | Tìm lại bản backup cũ, tải lên lại rất mất thời gian | `git revert <commit>` & push → tự động rollback |
| **Giám sát kết quả** | Phải tự mở web kiểm tra, lục log server | Thông báo trực quan (Badge tích xanh ✅ / đỏ ❌) |

---

## 🚀 Kết quả đạt được

- Mã nguồn được quản lý phiên bản rõ ràng bằng Git trên GitHub.
- Quy trình kiểm thử (CI) và phát hành (CD) khép kín, hoạt động ổn định.
- Website tự động cập nhật ngay sau khi lập trình viên cập nhật mã nguồn lên nhánh chính.
