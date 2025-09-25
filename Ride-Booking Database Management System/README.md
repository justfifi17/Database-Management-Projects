# 🚖 Ride-Booking Application Database

A fully designed and implemented **ride-booking application database** (inspired by Uber/Lyft) that supports passengers, drivers, rides, payments, ratings, and refunds with a focus on **performance, security, and high availability**.



## 📌 Features
- 👤 **Passenger & Driver Management** – profiles, authentication, licensing, and vehicles.  
- 🚗 **Ride Booking & Tracking** – pickup/drop-off locations, real-time ride status, fare calculation.  
- 💳 **Payments & Refunds** – multiple payment methods with refund tracking.  
- ⭐ **Ratings & Feedback** – passengers can rate drivers and leave comments.  
- 📊 **Analytics & Reports** – daily summaries, driver performance, peak hours.  
- 🛡 **Security & Reliability** – role-based access control, audit logs, encryption, replication, and backup strategies.  



## 🏗 Database Design
- **Entities**: Passenger, Driver, Vehicle, Ride, Location, Payment, Rating, Refund, Ride_Status_History.  
- **Normalization**: Verified up to **BCNF** – no redundancy or anomalies.  
- **ERD**: Covers one-to-many and one-to-one relationships (e.g., one passenger → many rides, one ride → one payment).  



## ⚡ Performance Optimizations
- **Indexes** on frequently queried fields (names, emails, ride status, dates).  
- **Materialized Views** for real-time dashboards:
  - Active rides view  
  - Driver ratings summary  
  - Passenger ride history  
  - Daily ride summary  
  - Peak hours analysis  
- **Stored Procedures**:
  - `GetPassengerRideHistory()` – fetch passenger’s ride history with ratings/feedback.  
  - `CalculateDriverEarnings()` – earnings summary for drivers over time.  



## 🔒 Security
- **Role-Based Access Control (RBAC)**: `ride_admin`, `ride_driver`, `ride_passenger`, `ride_analyst`.  
- **Password Hashing & Policies**: Secure authentication storage.  
- **Column-Level Encryption** for sensitive data.  
- **Audit Logging**: Tracks database activities.  
- **SSL Enforcement**: Secures client-server communication.  



## 💾 Backup & Recovery
- **Full & Incremental Backups** using stored procedures (`sp_FullDatabaseBackup`, `sp_IncrementalBackup`).  
- **Point-in-Time Recovery** (`sp_PointInTimeRecovery`).  
- **Replication Monitoring** via `ReplicationMonitor` table & alert system.  
- **NotificationLog** table for automated alerts (email/SMS/Slack integration possible).  


## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/ride-booking-db.git
cd ride-booking-db

