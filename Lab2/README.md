# Lab 2: Thiết lập Môi trường DevOps & Áp dụng Nguyên tắc CALMS

> **Học phần:** Vận hành & Bảo trì Phần mềm với DevOps  
> **Bài 2:** DevOps và các Nguyên tắc Cốt lõi (CALMS Framework & Toolchain)

---

## 👨‍🎓 Thông tin sinh viên

- **Họ và tên:** Ma Quốc Đan
- **Mã số sinh viên (MSSV):** DTC235180041
- **Kho lưu trữ (Repository):** [https://github.com/quocdan31/devops-lab2-calms](https://github.com/quocdan31/devops-lab2-calms)

---

## 🎯 Mục tiêu bài Lab

1. Cài đặt và cấu hình **DevOps Toolchain** cơ bản: Visual Studio Code, Git, Docker Desktop, Node.js.
2. Hiểu và áp dụng trọn vẹn **5 nguyên tắc CALMS của DevOps** qua bài tập thực tiễn.
3. Viết và chạy **Automation Script** (`setup-dev-env.ps1` / `setup-dev-env.sh`) để tự động hóa thiết lập môi trường phát triển (nguyên tắc **Automation**).
4. Sử dụng **Docker** để đóng gói ứng dụng Node.js, loại bỏ triệt để lỗi *"It works on my machine"* (nguyên tắc **Lean**).
5. Xây dựng **DevOps Toolchain Map** — định vị công cụ cho từng giai đoạn của vòng đời phần mềm (nguyên tắc **Measurement** & **Sharing**).

---

## 📁 Cấu trúc thư mục dự án

```text
devops-lab2-calms/
├── Dockerfile              # Cấu hình đóng gói ứng dụng vào Linux container
├── package.json            # Quản lý metadata và dependencies của ứng dụng Node.js
├── server.js               # Mã nguồn API microservice trả về thông tin môi trường
├── setup-dev-env.ps1       # Script tự động thiết lập môi trường (Windows PowerShell)
├── setup-dev-env.sh        # Script tự động thiết lập môi trường (Linux/Bash)
├── devops-check.sh         # Script kiểm tra phiên bản các công cụ trong Toolchain
├── .gitignore              # Bỏ qua các file rác, node_modules, log
└── README.md               # Báo cáo thực hành chi tiết và câu trả lời bài Lab
```

---

## 📋 NỘI DUNG THỰC HÀNH & KẾT QUẢ

### BƯỚC 1: Cài đặt DevOps Toolchain cơ bản

Kiểm tra các công cụ nền tảng đã cài đặt trên máy:
- **VS Code:** Trình soạn thảo mã nguồn chính, tích hợp GitLens, Docker extension, YAML.
- **Git (≥ 2.40):** Quản lý phiên bản phân tán (`git version 2.55.0.windows.5`).
- **Node.js:** Môi trường thực thi JavaScript (`v22.x` / `v18.x`).
- **Docker:** Nền tảng container hóa chuẩn OCI.

---

### BƯỚC 2: Automation — Kịch bản tự động hóa đầu tiên

#### 📌 Bài toán:
Team có 5 người, mỗi khi thành viên mới tham gia dự án thường mất hơn 2 giờ để đọc tài liệu, tải và cài đặt thủ công các công cụ, tạo thư mục, cấu hình Git... Làm sao để rút ngắn thời gian chỉ còn 2 phút?

#### 💡 Giải pháp tự động hóa:
> **Bài học DevOps #1: Bất cứ việc gì làm thủ công ≥ 2 lần → HÃY VIẾT SCRIPT TỰ ĐỘNG HÓA!**

Xây dựng script tự động hóa `setup-dev-env.ps1` (cho Windows) và `setup-dev-env.sh` (cho Linux/macOS) thực hiện toàn bộ:
1. Tự động kiểm tra điều kiện tiên quyết (Git, Node.js, VS Code).
2. Tự động sinh cấu trúc thư mục chuẩn: `src/`, `tests/`, `docs/`.
3. Tự động khởi tạo kho lưu trữ Git (`git init`) nếu chưa có.
4. Tự động sinh file `.gitignore` tiêu chuẩn ngăn chặn commit file rác, `node_modules`, log.

**Cách chạy script:**
```powershell
# Chạy trên PowerShell:
.\setup-dev-env.ps1
```

---

### BƯỚC 3: Lean — Tinh gọn quy trình & loại bỏ lãng phí với Docker

#### 📌 Bài toán "It works on my machine":
Developer viết mã trên Windows chạy tốt, nhưng đồng đội dùng macOS hay server chạy Linux thì bị lỗi do xung đột phiên bản Node.js và thư viện hệ điều hành.

#### 💡 Giải pháp với Docker:
Đóng gói toàn bộ ứng dụng + runtime Node.js 18 vào 1 Docker Container thống nhất thông qua `Dockerfile`:
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]
```

#### Lệnh thực thi:
```bash
# Build image
docker build -t devops-lab2-app .

# Chạy container
docker run -d -p 3000:3000 --name lab2-app devops-lab2-app

# Kiểm tra kết quả
curl http://localhost:3000
```

#### Kết quả trả về JSON:
```json
{
  "message": "Hello from Docker & DevOps!",
  "lab": "DevOps Lab 2 — Lean Principle & CALMS Framework",
  "student": "Ma Quốc Đan",
  "mssv": "DTC235180041",
  "node_version": "v18.x.x",
  "platform": "linux"
}
```

#### Bảng so sánh nguyên tắc Lean:
| Không có Docker (Lãng phí) | Có Docker (Lean) |
| :--- | :--- |
| Cài Node.js thủ công từng máy | Node.js và thư viện đóng gói sẵn trong image |
| Lỗi "Trên máy tôi chạy được mà!" | Container chạy nhất quán 100% ở mọi môi trường |
| Xung đột OS giữa Windows/macOS/Linux | Chạy chung nhân Linux container chuẩn hóa |
| Mất 30 phút - 1 giờ setup môi trường | `docker run` chỉ mất 5 giây |

---

### BƯỚC 4: DevOps Toolchain Map

#### 1. Bảng công cụ DevOps theo từng giai đoạn:
| Giai đoạn | Công cụ | Mục đích |
| :--- | :--- | :--- |
| **Plan** | GitHub Projects, Jira | Lập kế hoạch, quản lý backlog, sprints, roadmap |
| **Code** | Git, GitHub, VS Code | Soạn thảo mã nguồn, quản lý phiên bản phân tán |
| **Build** | Maven, Gradle, npm | Đóng gói mã nguồn thành sản phẩm (JAR/WAR/dist) |
| **Test** | Postman/Newman, SonarQube, OWASP ZAP | Kiểm thử API, phân tích chất lượng code và bảo mật |
| **Deploy** | Docker, Terraform, AWS | Container hóa và cấp phát hạ tầng dưới dạng code (IaC) |
| **CI/CD** | GitHub Actions, Jenkins | Tự động hóa toàn bộ đường ống kiểm thử và phát hành |
| **Artifact** | Nexus OSS, Docker Hub | Quản lý và lưu trữ artifact, Docker images |
| **Monitor** | Prometheus, Grafana, CloudWatch | Giám sát hiệu năng hệ thống, cảnh báo lỗi thời gian thực |

#### 2. Tổng kết CALMS trong thực tế:
| Trụ cột CALMS | Hoạt động đã thực hiện | Mục đích đạt được |
| :--- | :--- | :--- |
| **C (Culture)** | Làm việc theo Git Flow, văn hóa cùng chịu trách nhiệm | Xóa bỏ ranh giới silo giữa lập trình viên và vận hành |
| **A (Automation)** | Tự động hóa khởi tạo môi trường (`setup-dev-env.ps1`) | Loại bỏ thao tác thủ công lặp đi lặp lại |
| **L (Lean)** | Đóng gói ứng dụng vào Docker Container | Loại bỏ lãng phí thời gian và lỗi sai khác môi trường |
| **M (Measurement)** | Đo lường thời gian chạy script, monitor container metrics | Nắm bắt số liệu thực tế để tối ưu quy trình |
| **S (Sharing)** | Chia sẻ Dockerfile, README, script dùng chung trong team | Minh bạch hóa tri thức, ai trong team cũng dùng được |

---

### BƯỚC 5: CALMS Self-Assessment (Tự đánh giá DevOps Maturity)

#### 5.1 Bảng tự đánh giá:
| Trụ cột | 1 (Yếu) | 3 (Trung bình) | 5 (Xuất sắc) | Điểm tự đánh giá |
| :--- | :--- | :--- | :--- | :---: |
| **Culture** | Dev vs Ops đổ lỗi cho nhau | Dev và Ops ngồi chung team | Mọi người cùng chịu trách nhiệm production | **4/5** |
| **Automation** | Deploy thủ công 100% | Có CI/CD cho 1 số project | Toàn bộ pipeline tự động hóa | **4/5** |
| **Lean** | Setup môi trường mất > 1 ngày | Có script, Docker 1 phần | 1 lệnh script/Docker chạy ngay | **4/5** |
| **Measurement** | Không biết app có chạy không | Có monitoring cơ bản | Dashboard real-time + alert cảnh báo | **3.5/5** |
| **Sharing** | Không document, giấu nghề | Có tài liệu wiki nội bộ | Code review + post-mortem + docs chuẩn | **4.5/5** |
| **TỔNG ĐIỂM** | | | | **20/25** |

#### 5.2 Kế hoạch cải thiện cụ thể:
1. **Automation:** Tích hợp script `setup-dev-env` và Docker vào GitHub Actions CI/CD để tự động build và test mỗi khi có pull request mới.
2. **Lean & Containerization:** Đa tầng hóa Dockerfile (multi-stage build) để giảm dung lượng image xuống dưới 50MB, giúp deploy nhanh hơn.
3. **Measurement:** Thiết lập hệ thống giám sát Prometheus và Grafana để theo dõi thời gian phản hồi (latency), tỷ lệ lỗi (error rate) và mức sử dụng CPU/RAM của container.
