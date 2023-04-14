#include "emojipicker.h"

emojiPicker::emojiPicker(QObject *parent)
    : QAbstractItemModel(parent)
{
}

QVariant emojiPicker::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!
}

QModelIndex emojiPicker::index(int row, int column, const QModelIndex &parent) const
{
    // FIXME: Implement me!
}

QModelIndex emojiPicker::parent(const QModelIndex &index) const
{
    // FIXME: Implement me!
}

int emojiPicker::rowCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

int emojiPicker::columnCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

QVariant emojiPicker::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    // FIXME: Implement me!
    return QVariant();
}
