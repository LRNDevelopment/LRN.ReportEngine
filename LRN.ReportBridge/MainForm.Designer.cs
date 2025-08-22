using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace ExcelETLWinApp
{
    partial class MainForm
    {
        private System.ComponentModel.IContainer components = null;
        private System.Windows.Forms.TabControl tabControl;
        private System.Windows.Forms.TabPage tabUpload;
        private System.Windows.Forms.TabPage tabDownload;
        private System.Windows.Forms.TabPage tabETL;
        private System.Windows.Forms.ComboBox cmbUploadReportType;
        private System.Windows.Forms.Button btnSelectFile;
        private System.Windows.Forms.TextBox txtFile;
        private System.Windows.Forms.Button btnUpload;
        private System.Windows.Forms.ComboBox cmbDownloadReportType;
        private System.Windows.Forms.Button btnDownload;
        private System.Windows.Forms.Button btnRunETL;
      
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
                components.Dispose();
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            tabControl = new TabControl();
            tabUpload = new TabPage();
            cmbUploadReportType = new ComboBox();
            btnSelectFile = new Button();
            txtFile = new TextBox();
            btnUpload = new Button();
            tabDownload = new TabPage();
            cmbDownloadReportType = new ComboBox();
            btnDownload = new Button();
            tabETL = new TabPage();
            btnRunETL = new Button();
            tabPage2 = new TabPage();
            txtPassword = new TextBox();
            txtPasswordHash = new TextBox();
            label1 = new Label();
            label2 = new Label();
            Enrypt = new Button();
            button1 = new Button();
            tabControl.SuspendLayout();
            tabUpload.SuspendLayout();
            tabDownload.SuspendLayout();
            tabETL.SuspendLayout();
            tabPage2.SuspendLayout();
            SuspendLayout();
            // 
            // tabControl
            // 
            tabControl.Controls.Add(tabUpload);
            tabControl.Controls.Add(tabDownload);
            tabControl.Controls.Add(tabETL);
            tabControl.Controls.Add(tabPage2);
            tabControl.Font = new Font("Segoe UI", 9F);
            tabControl.Location = new Point(12, 12);
            tabControl.Name = "tabControl";
            tabControl.SelectedIndex = 0;
            tabControl.Size = new Size(520, 300);
            tabControl.TabIndex = 0;
            // 
            // tabUpload
            // 
            tabUpload.Controls.Add(cmbUploadReportType);
            tabUpload.Controls.Add(btnSelectFile);
            tabUpload.Controls.Add(txtFile);
            tabUpload.Controls.Add(btnUpload);
            tabUpload.Location = new Point(4, 29);
            tabUpload.Name = "tabUpload";
            tabUpload.Size = new Size(512, 267);
            tabUpload.TabIndex = 0;
            tabUpload.Text = "Upload";
            tabUpload.UseVisualStyleBackColor = true;
            // 
            // cmbUploadReportType
            // 
            cmbUploadReportType.DropDownStyle = ComboBoxStyle.DropDownList;
            cmbUploadReportType.Location = new Point(20, 20);
            cmbUploadReportType.Name = "cmbUploadReportType";
            cmbUploadReportType.Size = new Size(300, 28);
            cmbUploadReportType.TabIndex = 0;
            // 
            // btnSelectFile
            // 
            btnSelectFile.Location = new Point(20, 60);
            btnSelectFile.Name = "btnSelectFile";
            btnSelectFile.Size = new Size(100, 35);
            btnSelectFile.TabIndex = 1;
            btnSelectFile.Text = "Select File";
            btnSelectFile.Click += btnSelectFile_Click;
            // 
            // txtFile
            // 
            txtFile.Location = new Point(130, 68);
            txtFile.Name = "txtFile";
            txtFile.ReadOnly = true;
            txtFile.Size = new Size(300, 27);
            txtFile.TabIndex = 2;
            // 
            // btnUpload
            // 
            btnUpload.Location = new Point(318, 117);
            btnUpload.Name = "btnUpload";
            btnUpload.Size = new Size(112, 38);
            btnUpload.TabIndex = 3;
            btnUpload.Text = "Upload";
            btnUpload.Click += btnUpload_Click;
            // 
            // tabDownload
            // 
            tabDownload.Controls.Add(cmbDownloadReportType);
            tabDownload.Controls.Add(btnDownload);
            tabDownload.Location = new Point(4, 29);
            tabDownload.Name = "tabDownload";
            tabDownload.Size = new Size(512, 267);
            tabDownload.TabIndex = 1;
            tabDownload.Text = "Download";
            tabDownload.UseVisualStyleBackColor = true;
            // 
            // cmbDownloadReportType
            // 
            cmbDownloadReportType.DropDownStyle = ComboBoxStyle.DropDownList;
            cmbDownloadReportType.Location = new Point(20, 20);
            cmbDownloadReportType.Name = "cmbDownloadReportType";
            cmbDownloadReportType.Size = new Size(300, 28);
            cmbDownloadReportType.TabIndex = 0;
            // 
            // btnDownload
            // 
            btnDownload.Location = new Point(20, 60);
            btnDownload.Name = "btnDownload";
            btnDownload.Size = new Size(98, 33);
            btnDownload.TabIndex = 1;
            btnDownload.Text = "Download";
            btnDownload.Click += btnDownload_Click;
            // 
            // tabETL
            // 
            tabETL.Controls.Add(btnRunETL);
            tabETL.Location = new Point(4, 29);
            tabETL.Name = "tabETL";
            tabETL.Size = new Size(512, 267);
            tabETL.TabIndex = 2;
            tabETL.Text = "ETL Processor";
            tabETL.UseVisualStyleBackColor = true;
            // 
            // btnRunETL
            // 
            btnRunETL.Location = new Point(20, 20);
            btnRunETL.Name = "btnRunETL";
            btnRunETL.Size = new Size(135, 35);
            btnRunETL.TabIndex = 0;
            btnRunETL.Text = "Run ETL Process";
            btnRunETL.Click += btnRunETL_Click;
            // 
            // tabPage2
            // 
            tabPage2.Controls.Add(button1);
            tabPage2.Controls.Add(Enrypt);
            tabPage2.Controls.Add(label2);
            tabPage2.Controls.Add(label1);
            tabPage2.Controls.Add(txtPasswordHash);
            tabPage2.Controls.Add(txtPassword);
            tabPage2.Location = new Point(4, 29);
            tabPage2.Name = "tabPage2";
            tabPage2.Padding = new Padding(3);
            tabPage2.Size = new Size(512, 267);
            tabPage2.TabIndex = 4;
            tabPage2.Text = "Password Hash";
            tabPage2.UseVisualStyleBackColor = true;
            // 
            // txtPassword
            // 
            txtPassword.Location = new Point(153, 30);
            txtPassword.Name = "txtPassword";
            txtPassword.Size = new Size(204, 27);
            txtPassword.TabIndex = 0;
            // 
            // txtPasswordHash
            // 
            txtPasswordHash.Location = new Point(153, 88);
            txtPasswordHash.Name = "txtPasswordHash";
            txtPasswordHash.Size = new Size(204, 27);
            txtPasswordHash.TabIndex = 1;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(6, 37);
            label1.Name = "label1";
            label1.Size = new Size(126, 20);
            label1.TabIndex = 2;
            label1.Text = "Decrypt Password";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(16, 95);
            label2.Name = "label2";
            label2.Size = new Size(116, 20);
            label2.TabIndex = 3;
            label2.Text = "Enrypt Password";
            // 
            // Enrypt
            // 
            Enrypt.Location = new Point(153, 168);
            Enrypt.Name = "Enrypt";
            Enrypt.Size = new Size(138, 35);
            Enrypt.TabIndex = 4;
            Enrypt.Text = "Enrypt";
            Enrypt.UseVisualStyleBackColor = true;
            Enrypt.Click += Enrypt_Click;
            // 
            // button1
            // 
            button1.Location = new Point(314, 172);
            button1.Name = "button1";
            button1.Size = new Size(134, 31);
            button1.TabIndex = 5;
            button1.Text = "Decrypt";
            button1.UseVisualStyleBackColor = true;
            button1.Click += button1_Click;
            // 
            // MainForm
            // 
            ClientSize = new Size(540, 320);
            Controls.Add(tabControl);
            Name = "MainForm";
            Text = "Excel ETL WinApp";
            tabControl.ResumeLayout(false);
            tabUpload.ResumeLayout(false);
            tabUpload.PerformLayout();
            tabDownload.ResumeLayout(false);
            tabETL.ResumeLayout(false);
            tabPage2.ResumeLayout(false);
            tabPage2.PerformLayout();
            ResumeLayout(false);
        }
        private TabPage tabPage2;
        private Label label2;
        private Label label1;
        private TextBox txtPasswordHash;
        private TextBox txtPassword;
        private Button button1;
        private Button Enrypt;
    }
}
