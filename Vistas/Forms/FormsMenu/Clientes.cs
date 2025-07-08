using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Vistas.Forms.FormsMenu
{
    public partial class Clientes : Form
    {
        private readonly ConnectionToSql connection = new ConnectionToSql();

        public Clientes()
        {
            InitializeComponent();
        }

        private void Clientes_Load(object sender, EventArgs e)
        {
            dgvlistadoClientes.DataSource = Index();
        }

        public DataTable Index()
        {
            using (SqlConnection conn = connection.GetConnection())
            {
                conn.Open();

                string sql = "Select nombre,apellido,dui,telefono,correo,fechaIngreso from Cliente";
                SqlCommand comando = new SqlCommand(sql, conn);
                SqlDataAdapter adapter = new SqlDataAdapter(comando);

                DataTable DatosVirtual = new DataTable();
                adapter.Fill(DatosVirtual);
                return DatosVirtual;
            }
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = connection.GetConnection())
            {
                conn.Open();

                string SqlInsert = "INSERT INTO Cliente (nombre, dui, telefono, correo, fechaIngreso) " +
                                   "VALUES (@Nombre, @dui, @telefono, @correo, @fechaIngreso)";

                SqlCommand comando1 = new SqlCommand(SqlInsert, conn);
                comando1.Parameters.AddWithValue("@Nombre", txtNombre.Text);
                comando1.Parameters.AddWithValue("@dui", txtDui.Text);
                comando1.Parameters.AddWithValue("@telefono", txtTelefono.Text);
                comando1.Parameters.AddWithValue("@correo", txtCorreo.Text);
                comando1.Parameters.AddWithValue("@fechaIngreso", Convert.ToDateTime(txtFechaIngreso.Text));

                comando1.ExecuteNonQuery();
            }

            MessageBox.Show("Cliente agregado correctamente");
            dgvlistadoClientes.DataSource = Index();
        }
    }
}
