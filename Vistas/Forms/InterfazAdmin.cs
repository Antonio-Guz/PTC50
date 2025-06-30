using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Vistas.Forms.FormsMenu;



namespace Presentacion
{
    
    public partial class InterfazAdmin : Form
    {
        private Clientes Clientes;
        private Empleados Empleados;
        private Inventariocs Inventariocs;
        private Vehiculos Vehiculos;

        public InterfazAdmin()
        {
            InitializeComponent();

        }

        private void AbrirFormulario(Form formulario)
        {
            if (!PanelForms.Controls.Contains(formulario))
            {
                formulario.TopLevel = false;
                formulario.FormBorderStyle = FormBorderStyle.None;
                formulario.Dock = DockStyle.Fill;
                PanelForms.Controls.Add(formulario);
                formulario.Show();
            }
            formulario.BringToFront();

        }

 


        private void InterfazAdmin_Load(object sender, EventArgs e)
        {
            pnlMenu.Width = 60; 
        }
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hwnd, int wmsg, int wparam, int lparam);
        protected override void WndProc(ref Message m)
        {
            const int HTLEFT = 10;
            const int HTRIGHT = 11;
            const int HTTOP = 12;
            const int HTTOPLEFT = 13;
            const int HTTOPRIGHT = 14;
            const int HTBOTTOM = 15;
            const int HTBOTTOMLEFT = 16;
            const int HTBOTTOMRIGHT = 17;
            const int WM_NCHITTEST = 0x84;

            const int RESIZE_HANDLE_SIZE = 10;

            if (m.Msg == WM_NCHITTEST)
            {
                base.WndProc(ref m);
                Point cursor = this.PointToClient(Cursor.Position);

                if (cursor.X <= RESIZE_HANDLE_SIZE)
                {
                    if (cursor.Y <= RESIZE_HANDLE_SIZE)
                        m.Result = (IntPtr)HTTOPLEFT;
                    else if (cursor.Y >= this.ClientSize.Height - RESIZE_HANDLE_SIZE)
                        m.Result = (IntPtr)HTBOTTOMLEFT;
                    else
                        m.Result = (IntPtr)HTLEFT;
                }
                else if (cursor.X >= this.ClientSize.Width - RESIZE_HANDLE_SIZE)
                {
                    if (cursor.Y <= RESIZE_HANDLE_SIZE)
                        m.Result = (IntPtr)HTTOPRIGHT;
                    else if (cursor.Y >= this.ClientSize.Height - RESIZE_HANDLE_SIZE)
                        m.Result = (IntPtr)HTBOTTOMRIGHT;
                    else
                        m.Result = (IntPtr)HTRIGHT;
                }
                else if (cursor.Y <= RESIZE_HANDLE_SIZE)
                {
                    m.Result = (IntPtr)HTTOP;
                }
                else if (cursor.Y >= this.ClientSize.Height - RESIZE_HANDLE_SIZE)
                {
                    m.Result = (IntPtr)HTBOTTOM;
                }
                return;
            }

            base.WndProc(ref m);
        }

        private void Pcontainer_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(this.Handle, 0x112, 0xf012, 0);
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void btnMinimizar_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
        }

        private void btnMaximize_Click(object sender, EventArgs e)
        {
            if (this.WindowState == FormWindowState.Normal)
            {
                this.WindowState = FormWindowState.Maximized;
            }
            else
            {
                this.WindowState = FormWindowState.Normal;
            }
        }

        private void btnMenu_Click(object sender, EventArgs e)
        {
            if (pnlMenu.Width == 60)
            {
                pnlMenu.Width = 240;
            }
            else
            {
                pnlMenu.Width = 60;
            }
        }



        private void pnlClientes_Click(object sender, EventArgs e)
        {
            if (Clientes == null || Clientes.IsDisposed)
                Clientes = new Clientes();

            AbrirFormulario(Clientes);

        }



        private void pnlVehiculos_Click(object sender, EventArgs e)
        {
            if (Vehiculos == null || Vehiculos.IsDisposed)
                Vehiculos = new Vehiculos();
            AbrirFormulario(Vehiculos);
        }

        private void pnlInventario_Click(object sender, EventArgs e)
        {
            if (Inventariocs == null || Inventariocs.IsDisposed)
                Inventariocs = new Inventariocs();
            AbrirFormulario(Inventariocs);
        }

        private void pnlEmpleados_Click(object sender, EventArgs e)
        {
            if (Empleados == null || Empleados.IsDisposed)
                Empleados = new Empleados();
            AbrirFormulario(Empleados);
        }
    }
}
