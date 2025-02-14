export interface Template {
  id: string;
  businessName: string;
  address: string;
  phone: string;
  email: string;
  columns: string[];
}

export interface InvoiceItem {
  description: string;
  quantity: number;
  rate: number;
  amount: number;
}

export interface Invoice {
  invoiceNumber: string;
  date: string;
  dueDate: string;
  clientName: string;
  clientEmail: string;
  clientPhone: string;
  clientAddress: string;
  items: InvoiceItem[];
  template: Template;
  subtotal: number;
  tax: number;
  total: number;
}