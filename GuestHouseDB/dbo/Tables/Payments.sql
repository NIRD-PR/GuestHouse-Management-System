CREATE TABLE [dbo].[Payments] (
    [PaymentID]     INT             NOT NULL,
    [BookingID]     INT             NOT NULL,
    [PaymentTypeID] INT             NOT NULL,
    [PaymentAmount] DECIMAL (18, 2) NOT NULL,
    [isActive]      BIT             DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([PaymentID] ASC),
    CONSTRAINT [FK_Payments_PaymentType] FOREIGN KEY ([PaymentTypeID]) REFERENCES [Master].[PaymentTypes] ([PaymentTypeID])
);

