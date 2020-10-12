<%@ Page Title="" Language="C#" MasterPageFile="~/Views/admin.Master" AutoEventWireup="true" CodeBehind="RoomPricing.aspx.cs" Inherits="GuestHouse.Views.RoomPricing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainBody" runat="server">
    <main>
        <div class="container-fluid">
            <div class="jumbotron" style="padding-top: 5px; padding-bottom: 5px;">
                    <h2 class="mt-4" style="color: #007bff; font-family: 'Raleway',sans-serif; font-size: 62px; font-weight: 600; line-height: 72px; margin: 0 0 0px; text-align: center; text-transform: uppercase;">Room Pricing</h2>
                </div>
            <div class="table-responsive">

                <form runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <div id="dvGrid" style="padding: 10px; width: 1200px; margin-top:30px">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="OnRowDataBound"
                                    DataKeyNames="RoomTypeID" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" PageSize="15" AllowPaging="true" OnPageIndexChanging="OnPaging"
                                    OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added." CssClass="gvBookings" HeaderStyle-CssClass="gvHeader" RowStyle-CssClass="gvRow"
                                    >
                                    <Columns>
                                        <asp:TemplateField HeaderText="Room Type" ItemStyle-Width="400px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRT" runat="server" Text='<%# Eval("RoomType") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtRT" runat="server" Text='<%# Eval("RoomType") %>' Width="140" Height="30px"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Per Day Rate" ItemStyle-Width="400px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRate" runat="server" Text='<%# Eval("Rate") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtRate" runat="server" Text='<%# Eval("Rate") %>' Width="140"></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true"
                                            EditText="<i aria-hidden='true' class='fa fa-pencil-alt'></i>" DeleteText="<i aria-hidden='true' class='fa fa-trash'></i>"
                                            CancelText="<i aria-hidden='true' class='fa fa-times'></i>" UpdateText="<i aria-hidden='true' class='fa fa-check'></i>" />
                                    </Columns>
                                </asp:GridView>
                                <table class="table table-striped " style="background-color: white ;font-family: Arial; color:#007bff   ; border: none 0px transparent; height: 25px; text-align: center; font-size: 16px; margin-top:40px" />


                                <tr>
                                    <td style="width: 150px">Room Type:<br />
                                        <asp:TextBox ID="txtRT" runat="server" Width="140" />
                                    </td>
                                    <td style="width: 150px">Room Price:<br />
                                        <asp:TextBox ID="txtRate" runat="server" Width="140" />
                                    </td>
                                    <td style="width: 150px"><br />
                                        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="Insert" />
                                    </td>
                                </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </form>

            </div>
        </div>
    </main>
</asp:Content>
